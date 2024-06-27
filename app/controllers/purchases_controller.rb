class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_product, only: [:index, :create]
  before_action :prohibit_purchase, only: [:index, :create]
  before_action :redirect_if_sold, only: [:index, :create]

  def index
    @purchase_delivery = PurchaseDelivery.new
    gon.clear
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_params)

    if @purchase_delivery.invalid?
      Rails.logger.debug(@purchase_delivery.errors.full_messages)
      render :index, status: :unprocessable_entity and return
    end

    if @purchase_delivery.save
      pay_item
      redirect_to root_path, notice: '購入が完了しました。'
    else
      Rails.logger.debug(@purchase_delivery.errors.full_messages)
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  rescue Payjp::PayjpError => e
    Rails.logger.error "PayjpError: #{e.message}"
    @purchase_delivery.errors.add(:base, "支払い処理中にエラーが発生しました。もう一度お試しください。")
    render :index, status: :unprocessable_entity
  end

  private

  def purchase_params
    params.require(:purchase_delivery).permit(
      :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number
    ).merge(user_id: current_user.id, product_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    charge = Payjp::Charge.create(
      amount: @product.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
    Rails.logger.info "Charge: #{charge.inspect}"
  end

  def load_product
    @product = Product.find(params[:item_id])
  end

  def prohibit_purchase
    redirect_to root_path if current_user == @product.user
  end

  def redirect_if_sold
    redirect_to root_path if @product.purchase.present?
  end
end
