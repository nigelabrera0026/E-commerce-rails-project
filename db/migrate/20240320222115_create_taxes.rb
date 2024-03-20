class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes do |t|
      t.decimal :pst
      t.decimal :gst
      t.decimal :hst
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
