# spec/factories/purchase_deliveries.rb
FactoryBot.define do
  factory :purchase_delivery do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { 'Test City' }
    house_number { 'Test House' }
    building_name { 'Test Building' }
    phone_number { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
