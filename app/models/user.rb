class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '漢字、ひらがな、全角カタカナのみ使用できます' }
  validates :family_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '漢字、ひらがな、全角カタカナのみ使用できます' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナのみ使用できます' }
  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナのみ使用できます' }
  validates :birthday, presence: true
end
