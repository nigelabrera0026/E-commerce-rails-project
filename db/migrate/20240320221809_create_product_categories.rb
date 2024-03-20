class CreateProductCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :product_categories do |t|
      t.references :product, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.text :description
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
