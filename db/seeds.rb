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
require 'open-uri'

# Admin
# AdminUser.create!(email:                 'admin@example.com',
#                   password:              'password',
#                   password_confirmation: 'password') if Rails.env.development?

# Category
# url = URI("https://dog.ceo/api/breeds/list/all")
# response = Net::HTTP.get(url)
# breed = JSON.parse(response)

# Pointing to the head of the json
# head = breed["message"].keys

# head.each do |data|
#   Category.create!(name: data)
# end

# Product
# 1000.times do
#   Product.create!(name: Faker::Creature::Dog.name + Faker::Creature::Dog.name)
# end

# Product category
# assign_breed = Category.pluck(:id)

# Product.find_each do |product|
#   cat_id = assign_breed.sample

#   ProductCategory.find_or_create_by!(
#     product_id: product.id,
#     category_id: cat_id
#   ) do |prodcat|
#     prodcat.description = Faker::JapaneseMedia::StudioGhibli.quote
#     prodcat.price = rand(100.0..3000.0).round(2)
#     prodcat.quantity = rand(1..10)
#   end
# end

# Province and Tax table
# province_tax = {
#   "Alberta" => {
#     "GST" => 5,
#     "HST" => nil,
#     "PST" => nil
#   },
#   "British Columbia" => {
#     "GST" => 5,
#     "HST" => nil,
#     "PST" => 7
#   },
#   "Manitoba" => {
#     "GST" => 5,
#     "HST" => nil,
#     "PST" => 7
#   },
#   "New Brunswick" => {
#     "GST" => nil,
#     "HST" => 15,
#     "PST" => nil
#   },
#   "Newfoundland and Labrador" => {
#     "GST" => nil,
#     "HST" => 15,
#     "PST" => nil
#   },
#   "Northwest Territories" => {
#     "GST" => 5,
#     "HST" => nil,
#     "PST" => nil
#   },
#   "Nova Scotia" => {
#     "GST" => nil,
#     "HST" => 15,
#     "PST" => nil
#   },
#   "Nunavut" => {
#     "GST" => 5,
#     "HST" => nil,
#     "PST" => nil
#   },
#   "Ontario" => {
#     "GST" => nil,
#     "HST" => 13,
#     "PST" => nil
#   },
#   "Prince Edward Island" => {
#     "GST" => nil,
#     "HST" => 15,
#     "PST" => nil
#   },
#   "Quebec" => {
#     "GST" => 5,
#     "HST" => nil,
#     "PST" => 9.975
#   },
#   "Saskatchewan" => {
#     "GST" => 5,
#     "HST" => nil,
#     "PST" => 6
#     },
#   "Yukon" => {
#     "GST" => 5,
#     "HST" => nil,
#     "PST" => nil
#   }
# }

# Province and Tax table
# province_tax.each do |name, rates|
#   province = Province.create!(name: name)

#   rates.each do |tax_name, val|
#     next if val.nil?

#     tax_record = Tax.find_or_initialize_by(province_id: province.id)
#     case tax_name
#     when "GST"
#       tax_record.gst = val / 100.0
#     when "PST"
#       tax_record.pst = val / 100.0
#     when "HST"
#       tax_record.hst = val / 100.0
#     end
#     tax_record.save!
#   end
# end

# inserting image and associations for the products
# ProductCategory.find_each do |product_category|
#   # Construct the API endpoint URL
#   category_name = product_category.category.name.downcase
#   api_url = "https://dog.ceo/api/breed/#{category_name}/images/random"

#   # Fetch the image URL from the API
#   begin
#     response = URI.open(api_url)
#     data = JSON.parse(response.read)
#     image_url = data['message']

#     # Attach the image to the product_category record
#     unless image_url.blank?
#       downloaded_image = URI.open(image_url)
#       product_category.image.attach(io: downloaded_image, filename: "category_#{product_category.id}.jpg")
#     end
#   rescue OpenURI::HTTPError => e
#     Rails.logger.error "Could not retrieve image for #{category_name}: #{e.message}"
#   end
# end

# Implementation of on sale
# on_sale_product_categories = ProductCategory.order(Arel.sql('RANDOM()')).limit(50)

# on_sale_product_categories.each do |product_category|
#   product_category.update(on_sale: true)
# end

# Temporarily insert something in the page
# PageContent.create(title: 'About Us', content: 'This is about us.', page_name: 'about')
# PageContent.create(title: 'Contact Us', content: 'Contact us here.', page_name: 'contact')

# Seeding new product
# Product
recent_products = []
2.times do
  recent_products << Product.create!(name: Faker::Creature::Dog.name + Faker::Creature::Dog.name)
end

# Product category
assign_breed = Category.pluck(:id)

# Only create product categories for the recently created products
recent_product_categories = []
recent_products.each do |product|
  cat_id = assign_breed.sample

  recent_product_categories << ProductCategory.find_or_create_by!(
    product_id: product.id,
    category_id: cat_id
  ) do |prodcat|
    prodcat.description = Faker::JapaneseMedia::StudioGhibli.quote
    prodcat.price = rand(100.0..3000.0).round(2)
    prodcat.quantity = rand(1..10)
  end
end

# inserting image and associations for the recently created product categories
recent_product_categories.each do |product_category|
  # Construct the API endpoint URL
  category_name = product_category.category.name.downcase
  api_url = "https://dog.ceo/api/breed/#{category_name}/images/random"

  # Fetch the image URL from the API
  begin
    response = URI.open(api_url)
    data = JSON.parse(response.read)
    image_url = data['message']

    # Attach the image to the product_category record
    unless image_url.blank?
      downloaded_image = URI.open(image_url)
      product_category.image.attach(io: downloaded_image, filename: "category_#{product_category.id}.jpg")
    end
  rescue OpenURI::HTTPError => e
    Rails.logger.error "Could not retrieve image for #{category_name}: #{e.message}"
  end
end

# information about tax
# GST and HST – The goods and services tax (GST)
# is a tax that you pay on most goods and
# services sold or provided in Canada.
# In New Brunswick, Newfoundland and Labrador,
# Nova Scotia, Ontario and Prince Edward Island,
# the GST has been blended with the provincial sales
# tax and is called the harmonized sales tax (HST).

# Destroy Script in chronological order
# AdminUser.destroy_all
# ProductCategory.destroy_all
# Category.destroy_all
# Product.destroy_all
# User.destroy_all
# Tax.destroy_all
# Province.destroy_all

# run rails db:purge_db.rake
