class Province < ApplicationRecord
  has_many :users
  has_many :taxes
  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name] # Add any other attributes you want to be searchable for Province
  end
end
