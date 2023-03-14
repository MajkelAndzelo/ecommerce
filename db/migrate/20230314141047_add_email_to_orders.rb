class AddEmailToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :email, :string
  end
end
