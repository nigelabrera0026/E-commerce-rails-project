class ProductCategory < ApplicationRecord
  has_many :orders
  has_one_attached :image

  belongs_to :product
  belongs_to :category

  validates :product_id, presence: true
  validates :category_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Ransackable Associations
  def self.ransackable_associations(auth_object = nil)
    # Only allow searching on these associations
    %w[product category]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id product_id category_id price quantity created_at updated_at] # Update this list with the attributes you want searchable
  end
end
