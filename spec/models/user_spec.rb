require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるパターン' do
      it 'nicknameとemail、passwordとpassword_confirmation、名字、名前、名字(カナ)、名前(カナ)、生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないパターン' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Nicknameを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Emailを入力してください')
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'hirate.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Emailは不正な値です')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Emailはすでに存在します')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Passwordを入力してください", "Passwordは不正な値です", "Password confirmationとPasswordの入力が一致しません")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password confirmationとPasswordの入力が一致しません', 'Passwordは6文字以上で入力してください', 'Passwordは6文字以上で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Password confirmationとPasswordの入力が一致しません')
      end
      it '名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Last nameを入力してください', 'Last nameは不正な値です')
      end
      it '名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First nameを入力してください', 'First nameは不正な値です')
      end
      it '名字(カナ)が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kanaを入力してください', 'Last name kanaは不正な値です')
      end
      it '名前(カナ)が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanaを入力してください', 'First name kanaは不正な値です')
      end
      it '名字(カナ)がカタカナ意外では登録できない' do
        @user.last_name_kana = 'foo'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kanaは不正な値です')
      end
      it '名前(カナ)がカタカナ意外では登録できない' do
        @user.first_name_kana = 'bar'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanaは不正な値です')
      end
      it '生年月日が空では登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Date of birthを入力してください')
      end
    end
  end
end