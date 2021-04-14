require 'rails_helper'

RSpec.describe PurchaseDestination, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      @purchase_destination = FactoryBot.build(:purchase_destination, user_id: user.id)
    end
    
    context '商品購入ができるとき' do
      it 'zip_code,purchase_id,municipality,address,telephone_numberが存在すれば購入できること' do
        expect(@purchase_destination).to be_valid
      end

      it 'zip_codeは{3桁-4桁}の数値の場合購入できる' do
        @purchase_destination.zip_code = '123-4567'
        expect(@purchase_destination).to be_valid
      end

      it 'prefecture_idが1以外の場合保存できること' do
        @purchase_destination.prefecture_id = 30
        expect(@purchase_destination).to be_valid
      end

      it 'telephone_numberが11桁以内の場合購入できること' do
        @purchase_destination.telephone_number = 12345678910
        expect(@purchase_destination).to be_valid
      end

    end

    context '商品購入ができないとき' do
      it 'zip_codeが空だと購入できないこと' do
        @purchase_destination.zip_code = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Zip code can't be blank")
      end

      it 'zip_codeはハイフンがないと購入できないこと' do
        @purchase_destination.zip_code = '1234567'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it 'zip_codeは{3桁-4桁}以外の桁数では購入できないこと' do
        @purchase_destination.zip_code = '1234-567'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end

      it 'prefecture_idが1では購入できないこと' do
        @purchase_destination.prefecture_id = 1
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'municipalityが空だと購入できないこと' do
        @purchase_destination.municipality = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Municipality can't be blank" )
      end

      it 'addressが空だと購入できないこと' do
        @purchase_destination.address = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Address can't be blank")
      end

      it 'telephone_numberが空だと購入できないこと' do
        @purchase_destination.telephone_number = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Telephone number can't be blank")
      end

      it 'telephone_numberはハイフンがあると購入できないこと' do
        @purchase_destination.telephone_number = 123-4567-8910
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Telephone number is too short (minimum is 10 characters)")
      end

      it 'telephone_numberが12桁以上では購入できないこと' do
        @purchase_destination.telephone_number = 123456789101
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Telephone number is too long (maximum is 11 characters)")
      end
    end
  end
end
