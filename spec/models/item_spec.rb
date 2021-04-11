require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品機能' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品出品ができるとき' do
      it 'image、item_name、explain、category、condition、delivery_charge、prefecture、shipping_date、priceが存在していれば保存できること' do
        expect(@item).to be_valid
      end

      it 'item_nameが40文字以内であれば保存できること' do
        @item.item_name = 'a' * 40
        expect(@item).to be_valid
      end

      it 'explainが1,000文字以内であれば保存できること' do
        @item.explain = 'a' * 1000
        expect(@item).to be_valid
      end

      it 'category_idが1以外の場合保存できること' do
        @item.category_id = 5
        expect(@item).to be_valid
      end

      it 'condition_idが1以外の場合保存できること' do
        @item.condition_id = 3
        expect(@item).to be_valid
      end

      it 'delivery_charge_idが1以外の場合保存できること' do
        @item.delivery_charge_id = 3
        expect(@item).to be_valid
      end

      it 'prefecture_idが1以外の場合保存できること' do
        @item.prefecture_id = 30
        expect(@item).to be_valid
      end

      it 'shipping_date_idが1以外の場合保存できること' do
        @item.shipping_date_id = 3
        expect(@item).to be_valid
      end

      it 'priceが半角数字の場合保存できること' do
        @item.price = 1000
        expect(@item).to be_valid
      end

    end

    context '商品出品できないとき' do
      it 'imageが空では保存できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'item_nameが空では保存できないこと' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it 'item_nameが40文字以上では保存できないこと' do
        @item.item_name = 'a' * 50
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name is too long (maximum is 40 characters)")
      end

      it 'explainが空では保存できないこと' do
        @item.explain =  ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explain can't be blank")
      end

      it 'explainが1,000文字以上では保存できないこと' do
        @item.explain = 'a' * 1001 
        @item.valid?
        expect(@item.errors.full_messages).to include("Explain is too long (maximum is 1000 characters)")
      end

      it 'category_idが1では保存できないこと' do
        @item.category_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it 'condition_idが1では保存できないこと' do
        @item.condition_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end

      it 'delivery_charge_idが1では保存できないこと' do
        @item.delivery_charge_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge must be other than 1")
      end

      it 'prefecture_idが1では保存できないこと' do
        @item.prefecture_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'shipping_dateが1では保存できないこと' do
        @item.shipping_date_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date must be other than 1")
      end

      it 'priceが空では保存できないこと' do
        @item.price = '' 
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角数字では保存できないこと' do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'priceが数字以外では保存できないこと' do
        @item.price = '一万二千'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'priceが300より少ない場合保存できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'priceが9,999,999より大きい場合保存できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it 'userが紐づいていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end


    end
  end
end
