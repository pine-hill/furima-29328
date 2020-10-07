class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :ordered_item, dependent: :destroy
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :handling_time
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition

  validates :name, :description, :category_id, 
            :condition_id, :handling_time_id, :postage_id, :prefecture_id,:image, presence: true
  validates :price, inclusion: {in: 300..9999999 }, format: { with: /\A[0-9]+\z/ }
  with_options numericality: { other_than: 1 }, presence: true do
    validates :category_id ,:condition_id ,:handling_time_id ,:postage_id ,:prefecture_id
  end
end