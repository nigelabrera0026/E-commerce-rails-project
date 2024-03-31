class CreatePageContents < ActiveRecord::Migration[7.1]
  def change
    create_table :page_contents do |t|
      t.string :title
      t.text :content
      t.string :page_name

      t.timestamps
    end
  end
end
