namespace :cleanup do
  desc "Delete products and associated product categories created from yesterday to today"
  task delete_recent_records: :environment do
    time_range = (Time.now.midnight - 1.day)..Time.now

    # Destroy associated product categories within the time range
    ProductCategory.includes(:product).where(created_at: time_range).find_each do |product_category|
      product_category.destroy
    end

    # Destroy products within the time range that may not have associated product categories
    Product.where(created_at: time_range).find_each do |product|
      product.destroy unless product.product_categories.exists?
    end
  end
end
