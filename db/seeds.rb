# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "net/http"
require "json"
require "faker"

# Admin
AdminUser.create!(email:                 'admin@example.com',
                  password:              'password',
                  password_confirmation: 'password') if Rails.env.development?

# Category
url = URI("https://dog.ceo/api/breeds/list/all")
response = Net::HTTP.get(url)
breed = JSON.parse(response)

# Pointing to the head of the json
head = breed["message"].keys

head.each do |data|
  Category.create!(name: data)
end

# Product
1000.times do
  Product.create!(name: Faker::Creature::Dog.name)
end

# Destroy Script in chronological order
# AdminUser.destroy_all
# Category.destroy_all
# Product.destroy_all
# User.destroy_all
# Tax.destroy_all
# Province.destroy_all
