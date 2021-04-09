require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_pronounceとfirst_name_pronounce、birthdayが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'last_nameが空では登録できないこと' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'first_nameが空では登録できないこと' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last_name_pronounceが空では登録できないこと' do
      @user.last_name_pronounce = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name pronounce can't be blank")
    end

    it 'first_name_pronounceが空では登録できないこと' do
      @user.first_name_pronounce = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name pronounce can't be blank")
    end

    it 'birthdayが空では登録できないこと' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

    it 'passwordが６文字以上で且つ英字と数字をどちらも含む場合に登録できること' do
      @user.password = 'aaa111'
      @user.password_confirmation = 'aaa111'
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = 'aaa11'
      @user.password_confirmation = 'aaa11'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'passwordが英字だけでは登録できないこと' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it 'passwordが数字だけでは登録できないこと' do
      @user.password = '111111'
      @user.password_confirmation = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = 'aaa111'
      @user.password_confirmation = 'aaa1111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'last_nameが全角の場合登録できること' do
      @user.last_name = '山田'
      expect(@user).to be_valid
    end

    it 'last_nameが半角英数字の場合登録できないこと' do
      @user.last_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
    end

    it 'first_nameが全角の場合登録できること' do
      @user.first_name = 'たろう'
      expect(@user).to be_valid
    end

    it 'first_nameが半角英数字の場合登録できないこと' do
      @user.first_name = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end

    it 'last_name_pronounceがカナ文字の場合登録できること' do
      @user.last_name_pronounce = 'テスト'
      expect(@user).to be_valid
    end

    it 'last_name_pronounceがカナ文字以外の場合登録できないこと' do
      @user.last_name_pronounce = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name pronounce is invalid")
    end

    it 'first_name_pronounceがカナ文字の場合登録できること' do
      @user.first_name_pronounce = 'テスト'
      expect(@user).to be_valid
    end

    it 'first_name_pronounceがカナ文字以外の場合登録できないこと' do
      @user.first_name_pronounce = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name pronounce is invalid")
    end
  end
end
