class Tax < ApplicationRecord
  belongs_to :province
  has_many :orders
  validates :province_id, presence: true
end
