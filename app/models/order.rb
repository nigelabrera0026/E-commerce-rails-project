class Order < ApplicationRecord
  belongs_to :user
  belongs_to :productcategory
  belongs_to :user
  belongs_to :tax
end
