class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product_categories
  belongs_to :tax

  validates :user_id, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :productcategory_id, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_id, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
