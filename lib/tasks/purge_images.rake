namespace :storage do
  desc "Purge all attached images"
  task purge_images: :environment do
    ProductCategory.find_each do |product_category|
      product_category.image.purge 
    end
    puts "All images have been purged."
  end
end
