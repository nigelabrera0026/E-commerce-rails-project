class Tax < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :PST, numericality: { greater_than_or_equal_to: 0 }
  validates :GST, numericality: { greater_than_or_equal_to: 0 }
  validates :HST, numericality: { greater_than_or_equal_to: 0 }
  validates :province_id, presence: true
end
