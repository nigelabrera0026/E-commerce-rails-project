namespace :db do
  desc "Purge ProductCategories and associated images"
  task purge_product_categories: :environment do
    puts "Purging all ProductCategories and associated images..."

    AdminUser.destroy_all
    ProductCategory.destroy_all
    Category.destroy_all
    Product.destroy_all
    User.destroy_all
    Tax.destroy_all
    Province.destroy_all
    puts "All ProductCategories and associated images have been purged."
  end
end
