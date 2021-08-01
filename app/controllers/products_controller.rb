class ProductsController < ApplicationController
  before_action :authenticate_account!, only: [:new, :create, :edit, :update, :destroy]

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
    admin_check
    @product = Product.new
  end

  def create
    admin_check
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "#{@product.name} has been created."
      redirect_to(products_path)
    else
      flash[:success] = "#{@product.name} has been created."
      render(:new)
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :product_type, :description, :price, :quantity, :available, :vintage, :image)
  end

  def admin_check
    if current_account.role != 'vadmin'
      redirect_back(fallback_location: root_path)
      flash[:error] = 'Sorry you aren\'t allowed to view that page.'
    end
  end
end
