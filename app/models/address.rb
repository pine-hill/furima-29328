class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :ordered_item
  belongs_to_active_hash :prefecture
  with_options presence: true do
    validates :prefecture_id, :city, :block
    validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :phone_number, format: { with: /\A\d{10,11}\z/}
  end
end