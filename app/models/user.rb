class User < ApplicationRecord
  belongs_to :province
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }
  validates :province_id, :password, :address, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    %w[id email username name] # Add other attributes you want to be searchable
  end

  def self.ransackable_associations(auth_object = nil)
    %w[province] # Add other associations you want to be searchable
  end
end
