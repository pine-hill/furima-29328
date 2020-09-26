require 'rails_helper'
describe Item do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('/Users/pine_hill/Pictures/test_image.png')
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it "商品名・値段・商品説明が登録されていて、選択したカテゴリのidが1でなければ登録できる" do
        expect(@item).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it "商品名が入力されていない場合" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Nameを入力してください")
      end
      it "価格が入力されていない場合" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Priceは一覧にありません", "Priceは不正な値です")
      end
      it "価格が300円より小さい場合" do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Priceは一覧にありません")
      end
      it "価格が9999999円より大きい場合" do
        @item.price = "10000000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Priceは一覧にありません")
      end
      it "価格に全角数字が入力されていた場合" do
        @item.price = "１２３４５６"
        @item.valid?
        expect(@item.errors.full_messages).to include("Priceは一覧にありません")
      end
      it "価格にアルファベットが入力されていた場合" do
        @item.price = "abcABC"
        @item.valid?
        expect(@item.errors.full_messages).to include("Priceは一覧にありません")
      end
      it "価格に漢字が入力されていた場合" do
        @item.price = "菅義偉"
        @item.valid?
        expect(@item.errors.full_messages).to include("Priceは一覧にありません")
      end
      it "価格にひらがなが入力されていた場合" do
        @item.price = "けやき"
        @item.valid?
        expect(@item.errors.full_messages).to include("Priceは一覧にありません")
      end
      it "商品の説明が入力されていない場合" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Descriptionを入力してください")
      end
      it "カテゴリーが選択されていない場合" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Categoryは1以外の値にしてください")
      end
      it "商品の状態が選択されていない場合" do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Conditionは1以外の値にしてください")
      end
      it "発送までの日数が選択されていない場合" do
        @item.handling_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Handling timeは1以外の値にしてください")
      end
      it "配送料の負担が選択されていない場合" do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postageは1以外の値にしてください")
      end
      it "発送元の地域が選択されていない場合" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefectureは1以外の値にしてください")
      end
    end
  end
end