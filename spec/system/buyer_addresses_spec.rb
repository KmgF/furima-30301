require 'rails_helper'

RSpec.describe "商品購入機能", type: :system do
  before do
    payjp_customer = double("P")
    @buyer_address=FactoryBot.build(:buyer_address)
    @product1 = FactoryBot.create(:product)
    @user2 = FactoryBot.create(:user)
    card_mock = double('Payjp Charge')
    allow(card_mock).to receive(:create)
    pay_bot = PayBot.new
    allow(pay_bot).to receive(:pay_item).and_return(card_mock)
  end

  context'ユーザーが商品を購入できる時'do
    it 'ログインしたユーザーで、その商品の出品者でなければ商品を購入できる'do
      # トップページへ遷移する
      visit root_path
      # product1を出品したユーザーではないユーザーでログインする
      visit new_user_session_path
      fill_in 'email',with: @user2.email
      fill_in 'password',with: @user2.password
      find('input[name="commit"]').click
      # 他のユーザーが出品した商品の購入ページへ移動する
      visit  product_buyers_path(@product1.id)
      # 正しい情報を入力する
      fill_in 'postal-code', with:@buyer_address.post_number
      select '北海道' ,from: 'prefecture'
      fill_in 'city', with:@buyer_address.city
      fill_in 'addresses', with:@buyer_address.house_number
      fill_in 'phone-number', with:@buyer_address.tel
      # 購入ボタンを押すとbuyerモデル、addressモデルのカウントが１上がる
      expect{
        find('input[name="commit"]').click
      }.to change{Buyer.count }.by(1)
      # トップページへ遷移する
      expect(page).to eq root_path
    end
  end

  context'ユーザーが商品を購入できない時' do
    it'ログインしたユーザーで、その商品の出品者自身が商品を購入しようとするとトップページへ遷移する'do
      # トップページへ移動する
      # ログインする
      # 自身が出品した商品購入ページへ移動する
      # 購入ページへは移動せず、トップページへ遷移する
    end
    it'ログアウト状態のユーザーは商品を購入しようとすると、ログインページへ遷移する' do
      # トップページへ移動する
      # 他のユーザーが出品した商品の購入ページへ移動する
      # ログインページへ移動する
    end
  end
end
