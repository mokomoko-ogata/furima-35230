require 'rails_helper'

def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "商品購入機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @card = FactoryBot.create(:card)
    @purchase_destination = FactoryBot.build(:purchase_destination)
    sleep(1)
  end

  context '商品購入できるとき' do
    it 'ログインしたユーザーは商品購入できる' do
      # ログインする
      basic_pass new_user_session_path
      #visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品詳細ページに遷移する
      visit item_path(@item.id)
      # 購入画面に進むボタンがあることを確認する
      expect(page).to have_content("購入画面に進む")
      # カード登録をしていない場合購入画面に遷移しようとするとカード登録ページに遷移する
      #visit item_purchases_path(@item.id)
      #expect(current_path).to eq(cards_new_path)
      # カード情報を入力する
      #fill_in "card_number", with: 4242424242424242
      #fill_in "exp_month", with: 4
      #fill_in "exp_year", with: 25
      #fill_in "cvc", with: 123

      # 登録するとCardsモデルのカウントが1上がる
      #expect{
      #  find('input[name="commit"]').click
      #}.to change { Card.count }.by(0)
      # トップページに遷移していることを確認する
      #expect(current_path).to eq(root_path)
      # 商品詳細ページに遷移する
      #visit item_path(@item.id)
      # 購入画面に遷移する
      #visit item_purchases_path(@item.id)
      # 配送先情報を入力する
      #fill_in 'purchase_destination[zip_code]', with: @purchase_destination.zip_code
      #select '北海道', from: "purchase_destination[prefecture_id]"
      #fill_in 'purchase_destination[municipality]', with: @purchase_destination.municipality
      #fill_in 'purchase_destination[address]', with: @purchase_destination.address
      #fill_in 'purchase_destination[telephone_number]', with: @purchase_destination.telephone_number
      # 購入ボタンを押すとDestinationsモデルとPurchasesモデルのカウントが1上がることを確認する
      #expect{
      #  find('input[name="commit"]').click
      #}.to change { Destination.count }.by(1)
      #expect{
      #  find('input[name="commit"]').click
      #}.to change { Purchase.count }.by(1)
      # トップページに遷移していることを確認する
      #expect(current_path).to eq(root_path)
      # Sold Outの表記があることを確認する
      #expect(page).to have_content("Sold Out!!")
    end
  end

  context '商品購入できないとき' do
    it '自分が出品した商品は購入できない' do
      # 商品を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item.user.email
      fill_in 'user[password]', with: @item.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品詳細ページに遷移する
      visit item_path(@item.id)
      # 購入画面に進むボタンがないことを確認する
      expect(page).to have_no_content("購入画面に進む")
    end
    it 'ログインしていないユーザーは商品購入できない' do
      # トップページにいる
      visit root_path
      # 商品詳細ページに遷移する
      visit item_path(@item.id)
      # 購入画面に進むボタンが無いことを確認する
      expect(page).to have_no_content("購入画面に進む")
    end
  end
end
