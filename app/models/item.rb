class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :ordered_item
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :handling_time
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition

  validates :name, :description, :category_id, 
            :condition_id, :handling_time_id, :postage_id, :prefecture_id,:image, presence: true
  validates :price, inclusion: {in: 300..9999999 }, format: { with: /\A[0-9]+\z/ }
  validates :category_id, numericality: { other_than: 1 }
  validates :condition_id, numericality: { other_than: 1 }
  validates :handling_time_id, numericality: { other_than: 1 }
  validates :postage_id, numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 1 }
end