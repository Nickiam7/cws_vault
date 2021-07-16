class CheckoutController < ApplicationController
  def create
    wine = Wine.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: wine.name,
        amount: wine.price,
        currency: 'usd',
        quantity: params[:qty],
        images: [wine.image.url],
        description: "Picking up at: #{params[:pickup]}",
        adjustable_quantity: {
          enabled: true,
          minimum: 1,
          maximum: 10,
        },
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    })
    respond_to do |format|
      format.js
    end
  end

end
