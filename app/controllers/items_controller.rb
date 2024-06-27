class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold, only: [:edit, :update]

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
      Rails.logger.error("Product save failed: #{params.inspect}")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to item_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_product
    Rails.logger.error("Params: #{params.inspect}")
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error("Product not found: #{e.message}")
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :condition_id, :delivery_cost_id, :prefecture_id,
                                    :delivery_day_id, :image).merge(user_id: current_user.id)
  end

  def correct_user
    redirect_to root_path unless current_user == @product.user
  end

  def redirect_if_sold
    if @product.sold?
      redirect_to root_path
    end
  end
end
