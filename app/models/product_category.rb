class ProductCategory < ApplicationRecord
  has_many :orders
  has_one_attached :image

  belongs_to :product
  belongs_to :category

  validates :product_id, presence: true
  validates :category_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
