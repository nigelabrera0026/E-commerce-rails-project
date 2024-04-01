class AddOnSaleToProductsCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :product_categories, :on_sale, :boolean, default: false
  end
end
