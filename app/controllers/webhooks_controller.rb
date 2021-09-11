class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials[:development][:stripe_webhook]
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      puts "Signature error"
      p e
      return
    end

    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      @product = Product.find_by(price: session.amount_total)
      @product.increment!(:quantity)
    when 'product.created'
      Stripe::Product.update(@product.stripe_product_id, images: [@product.image.url])
    end

    render json: { message: 'success' }
  end
end
