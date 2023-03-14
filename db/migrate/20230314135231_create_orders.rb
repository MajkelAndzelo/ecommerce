class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, default: "pending"
      t.decimal :total_price, precision: 8, scale: 2
      t.string :stripe_token
      t.string :stripe_charge_id
      t.string :name
      t.timestamps
    end
  end
end
