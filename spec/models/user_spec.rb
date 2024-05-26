require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、date_of_birthが存在すれば登録できる' do
        expect(@user).to be_valid

      end
    end
      
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")

      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '111'
        @user.password_confirmation = '222'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = "test.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = "1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = 'a' * 130
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end

      it 'passwordが英字だけでは登録できない' do
        @user.password = 'tttttt' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 英字と数字の両方を含めて設定してください")
      end

      it 'passwordが数字だけでは登録できない' do
        @user.password = '666666' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Password 英字と数字の両方を含めて設定してください")
      end

      it 'last_nameが空だと登録できない' do
        @user.last_name = '' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが空だと登録できない' do
        @user.first_name = '' 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = '' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = '' 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'last_nameが半角だと登録できない' do
        @user.last_name = 't' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
      end

      it 'first_nameが半角だと登録できない' do
        @user.first_name = 't' 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
      end

      it 'last_name_kanaが半角だと登録できない' do
        @user.last_name_kana = 't' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角文字を使用してください")
      end

      it 'first_name_kanaが半角だと登録できない' do
        @user.first_name_kana = 't' 
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角文字を使用してください")
      end

      it 'date_of_birthが空だと登録できない' do
        @user.date_of_birth = '' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end

    end   
  end
end

