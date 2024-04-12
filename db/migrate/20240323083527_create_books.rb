class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn_13
      t.decimal :list_price, precision: 8, scale: 2
      t.integer :publication_year
      t.integer :publisher_id
      t.string :edition


      t.timestamps
    end
  end
end
