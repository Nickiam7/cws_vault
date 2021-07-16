class WinesController < ApplicationController
  before_action :authenticate_account!, only: [:create, :new, :edit, :update, :destroy]

  def index
    @wines = Wine.all
  end

  def show
    @wine = Wine.find(params[:id])
  end

  def new
    admin_check
    @wine = Wine.new
  end

  def create
    @wine = Wine.create(wine_params)
    if @wine.save
      flash[:success] = "#{@wine.name} has been added."
      redirect_to(wines_path)
    else
      flash[:error] = 'Something went wrong'
      render(:new)
    end
  end

  def edit
    @wine = Wine.find(params[:id])
  end

  def update
    @wine = Wine.find(params[:id])
    if @wine.update(wine_params)
      flash[:success] = "#{@wine.name} has been updated."
      redirect_to(wine_path(@wine))
    else
      flash[:error] = 'Something went wrong'
      render(:edit)
    end
  end

  private

  def wine_params
    params.require(:wine).permit(:name, :price, :quantity, :vintage, :image, :description)
  end

  def admin_check
    unless current_account.vadmin?
      redirect_to(root_path)
      flash[:error] = "You don't have permission for this action."
    end
  end
end
