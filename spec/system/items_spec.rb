require 'rails_helper'

RSpec.describe "商品出品", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end

  context '商品出品できるとき' do
    it 'ログインしたユーザーは商品出品できる' do
      #ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      #商品出品ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')
      #出品ページに遷移する
      visit new_item_path
      #フォームに情報を入力する
      attach_file "item-image", "#{Rails.root}/public/images/test_image.png"
      fill_in 'item[item_name]', with: @item.item_name
      fill_in 'item[explain]', with: @item.explain
      select 'レディース', from: 'item[category_id]'
      select '未使用に近い', from: 'item[condition_id]'
      select '着払い(購入者負担)', from: 'item[delivery_charge_id]'
      select '北海道', from: 'item[prefecture_id]'
      select '1~2日で発送', from: 'item[shipping_date_id]'
      fill_in 'item[price]', with: @item.price
      #出品するとItemモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      #トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      #トップページには先ほど出品した内容の商品が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_image.png']")
      #トップページには先ほど出品した内容の商品が存在することを確認する（商品名）
      expect(page).to have_content(@item.item_name)
      #トップページには先ほど出品した内容の商品が存在することを確認する（価格）
      expect(page).to have_content(@item.price)
      #トップページには先ほど出品した内容の商品が存在することを確認する（送料の負担）
      expect(page).to have_content('着払い(購入者負担)')
    end
  end
  context '商品出品ができないとき' do
    it 'ログインしていないと商品出品ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 出品ページに遷移しようとするとログインページにリダイレクトされる
      get new_item_path 
      expect(response).to redirect_to "/users/sign_in"
    end
  end
end

RSpec.describe '商品情報編集', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '商品情報編集ができるとき' do
    it 'ログインしたユーザーは自分が出品した商品の商品情報を編集できる' do
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品1の詳細画面に遷移する
      visit item_path(@item1.id)
      # 編集ボタンがあることを確認する
      expect(page).to have_content('商品の編集')
      # 編集ページに遷移する
      visit edit_item_path(@item1.id)
      # 既に出品済みの内容がフォームに入っていることを確認する
      expect(
        find('#item-name').value
      ).to eq(@item1.item_name)
      expect(
        find('#item-info').value
      ).to eq(@item1.explain)
      expect(
        find('#item-category').value
      ).to eq("#{@item1.category_id}")
      expect(
        find('#item-sales-status').value
      ).to eq("#{@item1.condition_id}")
      expect(
        find('#item-shipping-fee-status').value
      ).to eq("#{@item1.delivery_charge_id}")
      expect(
        find('#item-prefecture').value
      ).to eq("#{@item1.prefecture_id}")
      expect(
        find('#item-scheduled-delivery').value
      ).to eq("#{@item1.shipping_date_id}")
      expect(
        find('#item-price').value
      ).to eq("#{@item1.price}")
      # 商品情報を編集する
      attach_file "item-image", "#{Rails.root}/public/images/test2_image.jpeg"
      fill_in 'item[item_name]', with: "#{@item1.item_name}+編集したテキスト"
      fill_in 'item[explain]', with: "#{@item1.explain}+編集したテキスト"
      select 'レディース', from: 'item[category_id]'
      select '未使用に近い', from: 'item[condition_id]'
      select '着払い(購入者負担)', from: 'item[delivery_charge_id]'
      select '北海道', from: 'item[prefecture_id]'
      select '1~2日で発送', from: 'item[shipping_date_id]'
      fill_in 'item[price]', with: "#{@item1.price + 200}"
      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)
      # 商品詳細ページに遷移したことを確認する
      expect(current_path).to eq(item_path(@item1.id))
      # 詳細ページには先ほど変更した内容の商品が存在している(画像)
      #expect(page).to have_selector("img[src$='test2_image.jpeg']")
      # 詳細ページには先ほど変更した内容の商品が存在している(商品名)
      expect(page).to have_content("#{@item1.item_name}+編集したテキスト")
      # 詳細ページには先ほど変更した内容の商品が存在している(説明)
      expect(page).to have_content("#{@item1.explain}+編集したテキスト")
      # 詳細ページには先ほど変更した内容の商品が存在している(カテゴリー)
      expect(page).to have_content("レディース")
      # 詳細ページには先ほど変更した内容の商品が存在している(状態)
      expect(page).to have_content("未使用に近い")
      # 詳細ページには先ほど変更した内容の商品が存在している(配送料の負担)
      expect(page).to have_content("着払い(購入者負担)")
      # 詳細ページには先ほど変更した内容の商品が存在している(発送元の地域)
      expect(page).to have_content("北海道")
      # 詳細ページには先ほど変更した内容の商品が存在している(発送までの日数)
      expect(page).to have_content("1~2日で発送")
      # 詳細ページには先ほど変更した内容の商品が存在している(販売価格)
      expect(page).to have_content("#{@item1.price + 200}")
    end
  end

  context '商品情報編集ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の編集画面には遷移できない' do
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品2の商品詳細ページに遷移する
      visit item_path(@item2.id)
      # 編集ボタンが無いことを確認する
      expect(page).to have_no_content('商品の編集')
    end
    it 'ログインしていないと商品の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 商品1の商品詳細ページに遷移する
      visit item_path(@item1.id)
      # 編集ボタンが無いことを確認する
      expect(page).to have_no_content('商品の編集')
      # 商品2の商品詳細ページに遷移する
      visit item_path(@item2.id)
      # 編集ボタンが無いことを確認する
      expect(page).to have_no_content('商品の編集')
    end
  end
end

RSpec.describe '商品削除', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '商品が削除できるとき' do
    it 'ログインしたユーザーは自分が出品した商品の削除ができる' do
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品1の詳細ページに遷移する
      visit item_path(@item1.id)
      # 削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードのカウントが1減ることを確認する
      expect{
        find('.item-destroy').click
      }.to change { Item.count }.by(-1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページには商品1の内容が存在しないことを確認する
      expect(page).to have_no_link href: item_path(@item1)
    end
  end
  context '商品削除ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の削除ができない' do
      # 商品1を出品したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item1.user.email
      fill_in 'user[password]', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品2の詳細ページに遷移する
      visit item_path(@item2.id)
      # 削除ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
    end
    it 'ログインしていないと商品の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # 商品1の詳細ページに遷移する
      visit item_path(@item1.id)
      # 削除ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
      # 商品2の詳細ページに遷移する
      visit item_path(@item2.id)
      # 削除ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end

RSpec.describe '商品詳細', type: :system do
  before do
    @item = FactoryBot.create(:item)
  end
  it 'ログインの有無に関わらず商品詳細ページに遷移できる' do
    # トップページに移動する
    visit root_path
    # 商品の詳細ページに遷移する
    visit item_path(@item.id)
    # 商品の詳細が表示されていることを確認する(画像)
    expect(page).to have_selector("img[src$='test_image.png']")
    # 商品の詳細が表示されていることを確認する(商品名)
    expect(page).to have_content(@item.item_name)
    # 商品の詳細が表示されていることを確認する(説明)
    expect(page).to have_content(@item.explain)
    # 商品の詳細が表示されていることを確認する(カテゴリー)
    expect(page).to have_content("レディース")
    # 商品の詳細が表示されていることを確認する(状態)
    expect(page).to have_content("新品、未使用")
    # 商品の詳細が表示されていることを確認する(配送料の負担)
    expect(page).to have_content("着払い(購入者負担)")
    # 商品の詳細が表示されていることを確認する(配送元の地域)
    expect(page).to have_content("北海道")
    # 商品の詳細が表示されていることを確認する(発送までの日数)
    expect(page).to have_content("1~2日で発送")
    # 商品の詳細が表示されていることを確認する(価格)
    expect(page).to have_content(@item.price)
  end
end