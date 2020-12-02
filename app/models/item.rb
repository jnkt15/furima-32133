class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :deliveryfee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_date

  with_options presence: true do
    validates :name, :text, :price, :image
    validates :price, numericality: { less_than: 9_999_999, greater_than: 299 }
  end

  validates :category_id, :condition_id, :deliveryfee_id, :prefecture_id, :shipping_date_id, numericality: { other_than: 1 }
end
