class CheckoutController < ApplicationController

  def customer
    current_account.stripe_customer_id if account_signed_in?
  end

  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      customer: customer,
      payment_method_types: ['card'],
      line_items: [{
        price: product.stripe_price_id,
        quantity: params[:qty],
        description: "Picking up at: #{params[:pickup]}",
        adjustable_quantity: {
          enabled: true,
          minimum: 1,
          maximum: 10,
        },
      }],
      mode: 'payment',
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
    })
    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(id: params[:session_id], expand: ['line_items'])
    @product_id = @session.line_items.data.first.price.product
    @product = Product.find_by(stripe_product_id: @product_id)
  end

  def cancel
  end

end
