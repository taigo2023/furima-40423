class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :product_id, :token

  with_options presence: true do
    validates :postal_code
    validates :city
    validates :house_number
    validates :phone_number
    validates :user_id
    validates :product_id
    validates :token
  end

  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :phone_number, length: { minimum: 10 }, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      purchase = Purchase.create!(user_id: user_id, product_id: product_id)
      Delivery.create!(
        purchase_id: purchase.id,
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        house_number: house_number,
        building_name: building_name,
        phone_number: phone_number
      )
    end
  end
end
