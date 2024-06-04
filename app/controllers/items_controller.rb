class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_product, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @products = Product.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      redirect_to item_path(product)
    else
      @product = product
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :condition_id, :delivery_cost_id, :prefecture_id,
                                    :delivery_day_id, :image).merge(user_id: current_user.id)
  end

  def correct_user
    @product = Product.find(params[:id])
    return if current_user == @product.user

    redirect_to root_path
  end
end
