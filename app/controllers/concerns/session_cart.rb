module SessionCart
  extend ActiveSupport::Concern

  included do
    before_action :initialize_session
    before_action :load_cart
  end

  private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Product.find(session[:cart])
  end
end
