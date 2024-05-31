FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 300..9_999_999).to_i }
    category_id { 2 }
    condition_id { 2 }
    delivery_cost_id { 2 }
    prefecture_id { 2 }
    delivery_day_id { 2 }
    association :user

    after(:build) do |product|
      product.image.attach(io: File.open(Rails.root.join('public/images/test_image.png')), filename: 'test_image.png',
                           content_type: 'image/png')
    end
  end
end
