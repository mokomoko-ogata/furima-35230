require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'カード情報登録機能' do
    before do
      @card = FactoryBot.build(:card)
    end
    it 'card_tokenとcustomer_tokenが存在すれば登録できる' do
      expect(@card).to be_valid
    end

    it 'card_tokenが空だと登録できない' do
      @card.card_token = nil
      @card.valid?
      expect(@card.errors.full_messages).to include("Card token can't be blank")
    end

    it 'customer_tokenが空だと登録できない' do
      @card.customer_token = nil
      @card.valid?
      expect(@card.errors.full_messages).to include("Customer token can't be blank")
    end

    it 'userが紐づいていないと登録できない' do
      @card.user = nil
      @card.valid?
      expect(@card.errors.full_messages).to include('User must exist')
    end
  end
end
