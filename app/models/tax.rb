class Tax < ApplicationRecord
  belongs_to :province
  has_many :orders
  validates :province_id, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
