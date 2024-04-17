class Product < ApplicationRecord
  validates :name, presence: true

  # This custom scope might not be necessary if you use Ransack for the search,
  # as Ransack can handle the query based on the defined ransackable attributes.
  scope :search_by_keyword_and_category, lambda { |keyword, category|
    products = keyword.present? ? where('name LIKE :keyword OR description LIKE :keyword', keyword: "%#{keyword}%") : all
    # Assuming category_id is a column in the ProductCategories table,
    # you may need a join here if you want to filter by category from the Product model.
    products = products.joins(:product_categories).where(product_categories: { category_id: category }) if category.present? && category != "none"
    products
  }

  # When overriding `ransackable_attributes`, you should call `super`
  # and then concatenate any additional fields you want to whitelist for searching.
  def self.ransackable_attributes(auth_object = nil)
    super + %w[name description] # Assuming 'description' is a field in your Product model.
  end

  # If you've defined associations that you want to include in Ransack searches,
  # list them here. No change is necessary if these were already correct.
  def self.ransackable_associations(auth_object = nil)
    %w[product_categories orders]
  end

  def add_to_cart
    product_id = params[:product_id]
    quantity = (params[:quantity] || 1).to_i

    # Load the current cart from the session or initialize it as an empty Hash
    cart = session[:cart] || {}

    # Update the quantity for the given product
    cart[product_id] = (cart[product_id] || 0) + quantity

    # Save the updated cart back into the session
    session[:cart] = cart

    redirect_to products_path, notice: 'Product added to cart'
  end
end
