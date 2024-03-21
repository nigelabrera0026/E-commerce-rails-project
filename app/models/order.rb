class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product_categories
  belongs_to :tax
end
