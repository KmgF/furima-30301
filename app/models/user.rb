class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :first_name
    validates :family_name
    validates :first_name_kana
    validates :family_name_kana
    validates :birthday
  end
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/ }

  with_options format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '漢字、ひらがな、全角カタカナのみ使用できます' } do
    validates :first_name
    validates :family_name
  end

  with_options format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナのみ使用できます' } do
    validates :first_name_kana
    validates :family_name_kana
  end

  has_many :products
  has_many :buyers
end
