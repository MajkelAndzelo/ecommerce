class AddAddressToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :address, :string
  end
end
