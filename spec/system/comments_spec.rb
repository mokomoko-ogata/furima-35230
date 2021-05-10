require 'rails_helper'

# テスト実行時はbasic認証をコメントアウト
RSpec.describe 'コメント投稿', type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @comment = Faker::Lorem.sentence
  end

  context 'コメント投稿ができるとき' do
    it 'ログインしたユーザーは商品詳細ページでコメント投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品詳細ページに遷移する
      visit item_path(@item.id)
      # フォームに情報を入力する
      fill_in 'comment[text]', with: @comment
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
        sleep 5
      end.to change { Comment.count }.by(1)
      # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_content @comment
    end
  end
  context 'コメント投稿できないとき' do
    it 'ログインしていないユーザーは商品詳細ページでコメント投稿できない' do
      # 商品詳細ページに遷移する
      visit item_path(@item.id)
      # フォームに情報を入力する
      fill_in 'comment[text]', with: @comment
      # コメントを送信しても、Commentモデルのカウントは上がらない
      expect  do
        find('input[name="commit"]').click
        sleep 5
      end.to change { Comment.count }.by(0)
    end
  end
end
