class OrderedItem < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :item
  belongs_to_active_hash :prefecture
  has_one :address, dependent: :destroy
end
