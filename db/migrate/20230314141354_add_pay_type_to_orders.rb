class AddPayTypeToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :pay_type, :string
  end
end
