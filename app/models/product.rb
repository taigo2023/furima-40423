class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_cost
  belongs_to :prefecture
  belongs_to :delivery_day

  validates :image, :name, :description, presence: true

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  validates :price, format: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' }

  validates :category_id, :condition_id, :delivery_cost_id, :prefecture_id, :delivery_day_id,numericality: { other_than: 1 , message: "can't be blank"} 

end