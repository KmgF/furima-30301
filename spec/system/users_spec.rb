require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページへ移動する
      visit root_path
      # トップページには新規登録ページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録のページへ移動する
      visit new_user_registration_path
      # 正しい情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.family_name
      fill_in 'first-name', with: @user.first_name
      fill_in 'last-name-kana', with: @user.family_name_kana
      fill_in 'first-name-kana', with: @user.first_name_kana
      select @user.birthday.year, from: 'user_birthday_1i'
      select @user.birthday.month, from: 'user_birthday_2i'
      select @user.birthday.day, from: 'user_birthday_3i'
      # サインアップボタンを押すとユーザーモデルのカウントが１上がることを確認する
      expect do
        find('input[name=commit]').click
      end.to change { User.count }.by(1)
      # トップページへ移動する
      expect(current_path).to eq root_path
      # トップページにはログアウトボタンとマイページへ遷移するボタンが表示されている
      expect(page).to have_content('ログアウト')
      expect(page).to have_content(@user.nickname)
      # 新規登録へ遷移するボタンやログイン画面へ遷移するボタンが表示されていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザーが新規登録できない時' do
    it '誤った情報ではユーザーが新規登録できず、入力画面に止まる' do
      # トップページへ移動する
      visit root_path
      # トップページには新規登録ページへ遷移するボタンが存在することを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # 誤ったユーザー情報を入力する
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name-kana', with: ''
      fill_in 'first-name-kana', with: ''
      select '--', from: 'user_birthday_1i'
      select '--', from: 'user_birthday_2i'
      select '--', from: 'user_birthday_3i'
      # 登録ボタンを押してもユーザーモデルのカウントは上がらない
      expect do
        find('input[name = "commit"]').click
      end.to change { User.count }.by(0)
      # トップページへは遷移せず、入力画面に止まる
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ユーザーログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ユーザーがログインできる時' do
    it '正しい情報を入力すればログインできる' do
      # トップページへ移動する
      visit root_path
      # トップページにはログインページへ遷移するボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # トップページにはログアウトボタンとマイページへ遷移するボタンが表示されている
      expect(page).to have_content('ログアウト')
      expect(page).to have_content(@user.nickname)
      # 新規登録へ遷移するボタンやログイン画面へ遷移するボタンが表示されていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザーがログインできない時' do
    it '誤った情報を入力してもログインできない' do
      # トップページへ移動する
      visit root_path
      # トップページにはログインページへ移動するためのボタンが表示されている
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # 誤った情報を入力する
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      # ログインせず、ログインページへ止まる
      expect(current_path).to eq new_user_session_path
    end
  end
end
