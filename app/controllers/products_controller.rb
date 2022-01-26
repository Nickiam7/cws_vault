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
      redirect_to(stripe_image_product_path(@product))
    else
      flash[:error] = create_error_message(@product)
      render(:new)
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = 'Updated!'
      render(:edit)
    else
      flash[:error] = 'Something went wrong...'
      render(:edit)
    end
  end

  def set_stripe_image
    @product = Product.find(params[:id])
    Stripe::Product.update(@product.stripe_product_id, images: [@product.image.url])
    flash[:success] = 'Image has been successfully added to stripe dashboard.'
    redirect_to(edit_product_path(@product))
  end

  def stripe_image
    @product = Product.find(params[:id])
  end

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:qty]
    session[:cart] << id unless session[:cart].include?(id)
    redirect_back(fallback_location: product_path(id))
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_back(fallback_location: product_path(id))
  end


  private

  def product_params
    params.require(:product).permit(:name, :product_type, :description,
                                    :price, :quantity, :available,
                                    :vintage, :image, :featured
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
