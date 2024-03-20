class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :productcategory, null: false, foreign_key: true
      t.references :tax, null: false, foreign_key: true
      t.boolean :paid
      t.integer :total

      t.timestamps
    end
  end
end
