class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_date

  with_options presence: true do
    validates :item_name, length: { maximum: 40 }
    validates :explain, length: { maximum: 1_000 }
    validates :price, numericality: { with: /\A[0-9]+\z/ }
    validates_numericality_of :price, { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :prefecture_id
    validates :shipping_date_id
  end
end
