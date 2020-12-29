class BuyerAddress
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :post_number, :prefecture_id, :city, :house_number, :building_name, :tel, :token

  with_options presence: true do
    validates :product_id
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'ハイフンを入れてください' }
    validates :prefecture_id, numericality: { other_than: 1, message: '都道府県を選択してください' }
    validates :city
    validates :house_number
    validates :tel, numericality: true, length: { maximum: 11 }
    validates :token
  end

  def save
    buyer = Buyer.create(user_id: user_id, product_id: product_id)
    Address.create(post_number: post_number, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, tel: tel, buyer_id: buyer.id)
  end
end
