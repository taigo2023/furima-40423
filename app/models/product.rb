class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_cost
  belongs_to :prefecture
  belongs_to :delivery_day

  validates :name, :description, :price, presence: true

  validates :category_id, :condition_id, :delivery_cost_id, :prefecture_id, :delivery_day_id,numericality: { other_than: 1 , message: "can't be blank"} 

end
