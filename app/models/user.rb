class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :date_of_birth, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: '英字と数字の両方を含めて設定してください' 

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
  end
end


# 単体テストコードを書き、バリデーションが働いているかの検証は必要。
# ・メールアドレスが必須であること。
# ・メールアドレスが一意性であること。
# ・メールアドレスは、@を含む必要があること。
# ・パスワードが必須であること。
# ・パスワードは、6文字以上での入力が必須であること。
# ・パスワードとパスワード（確認）は、値の一致が必須であること。

# ニックネームが必須であること。
#  メールアドレスが必須であること。
#  メールアドレスが一意性であること。
#  メールアドレスは、@を含む必要があること。
#  パスワードが必須であること。
#  パスワードは、6文字以上での入力が必須であること
#  パスワードは、半角英数字混合での入力が必須であること
#  パスワードとパスワード（確認）は、値の一致が必須であること。