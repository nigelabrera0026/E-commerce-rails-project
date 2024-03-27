class ProductCategory < ApplicationRecord
  has_many :orders
  has_one_attached :image
  belongs_to :product
  belongs_to :category
end
