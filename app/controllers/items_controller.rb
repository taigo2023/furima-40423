class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
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

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :condition_id, :delivery_cost_id, :prefecture_id,
                                    :delivery_day_id, :image).merge(user_id: current_user.id)
  end
end
