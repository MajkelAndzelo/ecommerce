class AddCascadeToDeleteForCartInOrders < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :orders, :carts
    add_foreign_key :orders, :carts, on_delete: :cascade
  end
end
