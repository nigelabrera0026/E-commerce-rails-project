class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :name, presence: true

  # Ransackable Attributes
  def self.ransackable_attributes(auth_object = nil)
    # Only allow searching on these attributes
    %w[name created_at updated_at]
  end

  # Ransackable Associations
  def self.ransackable_associations(auth_object = nil)
    # If you want to include associated model names here
    %w[product_categories orders]
  end
end
