class BuyerAddress

  include ActiveModel::Model
  attr_accessor :user_id,:product_id,:post_number,:prefecture_id,:city,:house_number,:building_name,:tel,:buyer_id

  def save
    Buyer.create(user_id: user_id,product_id: product_id)
    Address.create(post_number: post_number, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, tel: tel,buyer_id: buyer_id)
  end
end