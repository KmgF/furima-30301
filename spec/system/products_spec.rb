require 'rails_helper'

RSpec.describe '商品の出品', type: :system do
  before do
    @product = FactoryBot.build(:product)
    @user = FactoryBot.create(:user)
  end

  context 'ユーザーが商品を出品できる時' do
    it 'ログインしたユーザーは正しい情報を入力すれば商品を投稿でき、トップページへ遷移する' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      # 出品ページへ移動する
      visit new_product_path
      # 画像を添付する
      image_path = Rails.root.join('public/images/zel3.png')
      attach_file('product[image]', image_path, make_visible: true)
      # フォームに情報を入力する
      fill_in 'item-name', with: @product.name
      fill_in 'item-info', with: @product.description
      select 'レディース', from: 'item-category'
      select '傷や汚れあり', from: 'item-sales-status'
      select '送料込み（発送者負担）', from: 'item-shipping-fee-status'
      select '京都府', from: 'item-prefecture'
      select '1~2日で発送', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: @product.price
      # 販売手数料が表示されている
      fee = @product.price * 0.1.floor
      expect(page).to have_content fee
      # 販売利益が表示されている
      fee = @product.price * 0.1
      benefit = @product.price - fee
      expect(page).to have_content benefit.floor
      # 送信するとProductモデルのカウントが１上がる
      expect do
        find('input[name="commit"]').click
      end.to change { Product.count }.by(1)
      # トップページへ移動する
      expect(current_path).to eq root_path
    end
  end

  context 'ユーザーが商品を出品できない時' do
    it 'ログインしたユーザーは誤った情報を入力すると商品は投稿できず、入力ページに止まる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      # 出品ページへ移動する
      visit new_product_path
      # フォームに誤った情報を入力する
      fill_in 'item-name', with: ''
      fill_in 'item-info', with: ''
      select '---', from: 'item-category'
      select '---', from: 'item-sales-status'
      select '---', from: 'item-shipping-fee-status'
      select '---', from: 'item-prefecture'
      select '---', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: ''
      # 送信してもProductモデルのカウントが変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Product.count }.by(0)
      # トップページへ移動せず、出品ページへ止まる
      expect(current_path).to eq '/products'
    end
    it 'ログインしていないと出品ページに遷移できない' do
      # 出品ページへ移動する
      visit new_product_path
      # 出品ページへ移動せず、ログインページへ移動する
      expect(current_path).to eq new_user_session_path
    end
  end
end
