# spec/factories/purchases.rb
FactoryBot.define do
  factory :purchase do
    association :user
    association :product
  end
end
