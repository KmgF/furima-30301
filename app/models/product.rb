class Product < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :category_id
    validates :status_id
    validates :shipment_prefecture_id
    validates :date_of_shipment_id
    validates :delivery_fee_id
    validates :user_id
  end

  validates :price, numericality: { only_integer: true, message: '半角数字のみ使用できます' }
  validates :price, numericality: { greater_than_or_equal_to: 300, message: '値段は最低300円以上に設定してください。' }
  validates :price, numericality: { less_than_or_equal_to: 9_999_999, message: '9999999円以上は設定できません' }

  with_options numericality: { other_than: 1, message: '選択してください' } do
    validates :category_id
    validates :status_id
    validates :shipment_prefecture_id
    validates :date_of_shipment_id
    validates :delivery_fee_id
  end

  validate :presence_image

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipment_prefecture
  belongs_to :date_of_shipment
  belongs_to :delivery_fee

  private

  def presence_image
    errors.add(:image, '画像を添付してください') if image.attached? == false
  end
end
