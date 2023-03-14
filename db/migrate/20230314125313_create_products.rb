class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.decimal :price
      t.integer :category_id
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
