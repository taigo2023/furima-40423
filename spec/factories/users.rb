FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { '山田' }  # 全角文字を直接指定
    first_name            { '太郎' }  # 全角文字を直接指定
    last_name_kana        { 'ヤマダ' }  # 全角カタカナを直接指定
    first_name_kana       { 'タロウ' }  # 全角カタカナを直接指定
    date_of_birth         { Faker::Date.birthday(min_age: 25, max_age: 30) }
  end
end