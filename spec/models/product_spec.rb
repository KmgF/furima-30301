require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.create(:product)
    sleep(1)
  end

  describe '商品の出品機能' do

  context '商品が出品できる時'do
    it '全ての項目を入力すると登録できる'do
    expect(@product).to be_valid
   end

end

  context '商品が出品できない時' do
   
    it '画像がないと投稿できない' do
      @product.image=nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Image 画像を添付してください")
    end
    it 'nameがないと投稿できない' do
      @product.name=""
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'descriptionがないと投稿できない' do
      @product.description=""
      @product.valid?
      expect(@product.errors.full_messages).to include("Description can't be blank")
    end
    it 'priceがないと投稿できない' do
      @product.price=""
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceは¥300より小さいと投稿できない' do
      @product.price = Faker::Number.between(from:0,to:299)
      @product.valid?
      expect(@product.errors.full_messages).to include("Price 値段は最低300円以上に設定してください。")
    end
    it 'priceは¥9,999,999より大きいと投稿できない' do
      @product.price = Faker::Number.number(digits: 8)
      @product.valid?
      expect(@product.errors.full_messages).to include("Price 9999999円以上は設定できません")
    end
    it 'priceは全角数字だと投稿できない' do
      @product.price = '１０００'
      @product.valid?
      expect(@product.errors.full_messages).to include("Price 半角数字のみ使用できます")
    end
    it 'priceは文字だと投稿できない' do
      @product.price = '値段'
      @product.valid?
      expect(@product.errors.full_messages).to include("Price 半角数字のみ使用できます")
    end
    it 'categotyを選択していないと投稿できない' do
      @product.category_id=1
      @product.valid?
      expect(@product.errors.full_messages).to include("Category 選択してください")
    end
    it 'statusを選択していないと投稿できない' do
      @product.status_id=1
      @product.valid?
      expect(@product.errors.full_messages).to include("Status 選択してください")
    end
    it 'shipment_prefectureを選択していないと投稿できない' do
      @product.shipment_prefecture_id=1
      @product.valid?
      expect(@product.errors.full_messages).to include("Shipment prefecture 選択してください")
    end
    it 'date_of_shipmentを選択していないと投稿できない' do
      @product.date_of_shipment_id=1
      @product.valid?
      expect(@product.errors.full_messages).to include("Date of shipment 選択してください")
    end
    it 'delivery_feeを選択していないと投稿できない' do
      @product.delivery_fee_id=1
      @product.valid?
      expect(@product.errors.full_messages).to include("Delivery fee 選択してください")
    end
    it 'user_idが紐づいていないと投稿できない' do
      @product.user_id = ""
      @product.valid?
      expect(@product.errors.full_messages).to include("User can't be blank")
    end

  end

end

end