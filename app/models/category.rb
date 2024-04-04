class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true

  def self.ransackable_associations(auth_object = nil)
    # Assuming you want to allow searching for categories based on products
    %w[products]
  end

  def self.ransackable_attributes(auth_object = nil)
    # Add the names of the attributes you want to be searchable here
    %w[name]
  end
end
