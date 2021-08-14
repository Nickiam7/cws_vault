class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: product.name,
        amount: product.price,
        currency: 'usd',
        quantity: params[:qty],
        images: [product.image.url],
        description: "Picking up at: #{params[:pickup]}",
        adjustable_quantity: {
          enabled: true,
          minimum: 1,
          maximum: 10,
        },
      }],
      mode: 'payment',
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
    })
    respond_to do |format|
      format.js
    end
  end

  def success
    @session
  end

  def cancel

  end

end
