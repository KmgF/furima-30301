require 'rails_helper'

RSpec.describe BuyerAddress, type: :model do
  describe '商品購入機能における購入者の情報保存' do
    before do
      @buyer_address = FactoryBot.build(:buyer_address)
    end

    context '商品が購入できる時' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@buyer_address).to be_valid
      end

      it 'building_nameは空白でも保存できる' do
        @buyer_address.building_name = ''
        expect(@buyer_address).to be_valid
      end
    end

    context '商品が購入できない時' do
      it 'product_idが紐づいていないと保存できない' do
        @buyer_address.product_id = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include product_id: ["can't be blank"]
      end
      it 'post_numberが空だと保存できない' do
        @buyer_address.post_number = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include post_number: ["can't be blank", 'ハイフンを入れてください']
      end
      it 'post_numberにはハイフンが含まれていないと保存できない' do
        @buyer_address.post_number = '1234567'
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include post_number: ['ハイフンを入れてください']
      end
      it 'prefecture_idが選択されていないと保存できない' do
        @buyer_address.prefecture_id = 1
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include prefecture_id: ['都道府県を選択してください']
      end
      it 'city が空だと保存できない' do
        @buyer_address.city = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include city: ["can't be blank"]
      end
      it 'house_numberが空だと保存できない' do
        @buyer_address.house_number = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include house_number: ["can't be blank"]
      end
      it 'telが空だと保存できない' do
        @buyer_address.tel = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include tel: ["can't be blank", 'is not a number']
      end
      it 'telにハイフンが含まれていると入力できない' do
        @buyer_address.tel = '012-123-567'
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include tel: ['is not a number']
      end
      it 'telが12桁以上だと保存できない' do
        @buyer_address.tel = '123456789012'
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include tel: ['is too long (maximum is 11 characters)']
      end

      it 'tokenが空だと保存できない' do
        @buyer_address.token = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.messages).to include token: ["can't be blank"]
      end
    end
  end
end
