class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product_categories
  belongs_to :tax

  validates :user_id, presence: true
  validates :productcategory_id, presence: true
  validates :tax_id, presence: true
end
