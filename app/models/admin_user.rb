class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
         
  def self.ransackable_attributes(auth_object = nil)
    # Return an array of the attribute names you want to be searchable.
    # Exclude sensitive attributes like 'encrypted_password', 'reset_password_token', etc.
    %w[id email created_at updated_at]
  end
end
