class ProductCategory < ApplicationRecord
  has_many :orders
  
  belongs_to :product
  belongs_to :category
end
