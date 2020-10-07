require 'rails_helper'

RSpec.describe OrderedItemAddress, type: :model do
  before do
    @ordered_item_address = FactoryBot.build(:ordered_item_address)
  end

  describe '決済機能' do
    it "トークンが返ってくれば購入できる" do
      expect(@ordered_item_address).to be_valid
    end
    it "トークンが空では購入できない" do
      @ordered_item_address.token = ""
      @ordered_item_address.valid?
      expect(@ordered_item_address.errors.full_messages).to include("Tokenを入力してください")
    end
  end
end