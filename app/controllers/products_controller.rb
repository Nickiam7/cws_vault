class ProductsController < ApplicationController
  before_action :authenticate_account!, only: %i[new create edit update destroy]
  before_action :admin_check, only: %i[new create destroy]

  def wines
    @wines = Product.wines
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "#{@product.name} has been created and added to Stripe dashboard."
      redirect_to(products_path)
    else
      flash[:error] = create_error_message(@product)
      render(:new)
    end
  end

  def destroy

  end

  private

  def product_params
    params.require(:product).permit(:name, :product_type, :description,
                                    :price, :quantity, :available,
                                    :vintage, :image
                                  )
  end

  def create_error_message(product)
    if product.name.present?
      "#{product.name} was not created. Correct the errors below."
    else
      "The current product was not created. Correct the errors below."
    end
  end

  def admin_check
    if current_account.role != 'vadmin'
      redirect_back(fallback_location: root_path)
      flash[:error] = 'Sorry you aren\'t allowed to view that page.'
    end
  end
end
