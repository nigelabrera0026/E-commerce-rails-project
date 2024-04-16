class ProductCategory < ApplicationRecord
  has_many :orders
  has_one_attached :image

  belongs_to :product
  belongs_to :category

  validates :product_id, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category_id, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :image_type
  validate :image_size

  attr_accessor :product_name

  # Scope for product categories that are on sale
  scope :on_sale, -> { where(on_sale: true) }

  # Scope for product categories added in the past 3 days
  scope :new_categories, -> { where("created_at >= ?", 3.days.ago) }

  # Scope for product categories updated in the past 3 days
  scope :recently_updated, -> { where("updated_at >= ?", 3.days.ago) }

  # Ransackable Associations
  def self.ransackable_associations(auth_object = nil)
    %w[product category]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id product_id category_id description price quantity created_at updated_at]
    super + %w[on_sale]
  end

  private

  def image_type
    if image.attached? && !image.blob.content_type.in?(%w(image/jpeg image/png image/jpg))
      errors.add(:image, "must be a JPEG or PNG")
    end
  end

  def image_size
    if image.attached? && image.blob.byte_size > 5.megabytes
      errors.add(:image, "is too big")
    end
  end
end
