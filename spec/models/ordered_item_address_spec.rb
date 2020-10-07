require 'rails_helper'

RSpec.describe OrderedItemAddress, type: :model do
  before do
    @ordered_item_address = FactoryBot.build(:ordered_item_address)
  end

  describe '住所登録機能' do
    context '住所が登録できる条件' do
      it "郵便番号・都道府県・市区町村・番地・ビル名・電話番号が入力されている場合" do
        expect(@ordered_item_address).to be_valid
      end
      it "ビル名が入力されていない場合" do
        @ordered_item_address.building_name = ''
        expect(@ordered_item_address).to be_valid
      end
    end
    
    context '住所が登録できない条件' do
      it "郵便番号が入力されていない場合" do
        @ordered_item_address.post_code = ''
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Post codeは不正な値です")
      end
      it "郵便番号にハイフンがない場合" do
        @ordered_item_address.post_code = '1234567'
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Post codeは不正な値です")
      end
      it "都道府県が選択されていない場合" do
        @ordered_item_address.prefecture_id = ''
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Prefectureを入力してください")
      end
      it "都道府県の選択が「---」場合" do
        @ordered_item_address.prefecture_id = '1'
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Prefectureは1以外の値にしてください")
      end
      it "市区町村が入力されていない場合" do
        @ordered_item_address.city = ''
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Cityを入力してください")
      end
      it "番地が入力されていない場合" do
        @ordered_item_address.block = ''
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Blockを入力してください")
      end
      it "電話番号が入力されていない場合" do
        @ordered_item_address.phone_number = ''
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it "電話番号にハイフンが入力されている場合" do
        @ordered_item_address.phone_number = '090-1234-5678'
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it "電話番号が12桁以上の場合" do
        @ordered_item_address.phone_number = '080123456789'
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include()
      end
      it "電話番号に数字以外が入力された場合" do
        @ordered_item_address.phone_number = 'aBう江オヵ7'
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
    end
  end

  describe '決済機能' do
    context '決済できる条件' do
      it "トークンが返ってきた場合" do
        expect(@ordered_item_address).to be_valid
      end
    end
    
    context '決済できない条件' do
      it "トークンが空の場合" do
        @ordered_item_address.token = ""
        @ordered_item_address.valid?
        expect(@ordered_item_address.errors.full_messages).to include("Tokenを入力してください")
      end
    end
  end
end