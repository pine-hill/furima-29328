require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end

  describe '住所登録機能' do
    context '住所が登録できる条件' do
      it "郵便番号・都道府県・市区町村・番地・ビル名・電話番号が入力されている場合" do
        expect(@address).to be_valid
      end
      it "ビル名が入力されていない場合" do
        @address.building_name = ''
        expect(@address).to be_valid
      end
    end
    
    context '住所が登録できない条件' do
      it "郵便番号が入力されていない場合" do
        @address.post_code = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Post codeは不正な値です")
      end
      it "郵便番号にハイフンがない場合" do
        @address.post_code = '1234567'
        @address.valid?
        expect(@address.errors.full_messages).to include("Post codeは不正な値です")
      end
      it "都道府県が選択されていない場合" do
        @address.prefecture_id = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefectureを入力してください")
      end
      it "市区町村が入力されていない場合" do
        @address.city = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Cityを入力してください")
      end
      it "番地が入力されていない場合" do
        @address.block = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Blockを入力してください")
      end
      it "電話番号が入力されていない場合" do
        @address.phone_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it "電話番号にハイフンが入力されている場合" do
        @address.phone_number = '090-1234-5678'
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it "電話番号が12桁以上の場合" do
        @address.phone_number = '080123456789'
        @address.valid?
        expect(@address.errors.full_messages).to include()
      end
    end
  end
end
