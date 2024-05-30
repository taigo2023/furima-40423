FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, mix_case: true) }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    date_of_birth         { Faker::Date.birthday(min_age: 25, max_age: 30) }
  end
end
