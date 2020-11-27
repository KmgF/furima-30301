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

end
