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

  validates :price  ,format: {with: /\A[0-9]+\z/,message:'半角数字のみ使用できます'}
  validates :price  ,numericality:{greater_than_or_equal_to: 300 ,message:'値段は最低300円以上に設定してください。'}
  validates :price  ,numericality:{less_than_or_equal_to: 9999999 ,message:'9999999円以上は設定できません'}
    


  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category
  validates :category_id ,numericality:{other_than:1}

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :status
  validates :status_id ,numericality:{other_than:1}

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :shipment_prefecture
  validates :shipment_prefecture_id ,numericality:{other_than:1}

  # extend ActiveHash::Associations::ActiveRecordExtensions
  #   belongs_to :date_of_shipment
  # validates :date_of_shipment_id ,numericality:{other_than:1}
end
