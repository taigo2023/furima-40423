require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品情報の保存' do
    context '商品情報がデータベースに保存できる場合' do
      it '商品画像、商品名、商品の説明、カテゴリー、商品の状態、配送料の負担、発送元の地域、発送までの日数、販売価格の情報があれば保存できる' do
        expect(@product).to be_valid
      end
    end
    context '商品情報がデータベースに保存できない場合' do
      it '商品画像を一枚つけないと保存できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名がないと保存できない' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明がないと保存できない' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報がないと保存できない' do
        @product.category_id = { id: 1, name: '---' }
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
      it '商品状態の情報がないと保存できない' do
        @product.category_id = { id: 1, name: '---' }
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
      it '商品状態の情報がないと保存できない' do
        @product.condition_id = { id: 1, name: '---' }
        @product.valid?
        expect(@product.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担の情報がないと保存できない' do
        @product.delivery_cost_id = { id: 1, name: '---' }
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery cost can't be blank")
      end
      it '発送元の地域の情報がないと保存できない' do
        @product.prefecture_id = { id: 1, name: '---' }
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数の情報がないと保存できない' do
        @product.delivery_day_id = { id: 1, name: '---' }
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery day can't be blank")
      end
      it '価格の情報がないと保存できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      it '価格は¥300未満では保存できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格は¥9,999,999を越えると保存できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '価格は半角数値でないと保存できない' do
        @product.price = '５００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
