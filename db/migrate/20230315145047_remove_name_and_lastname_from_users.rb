class RemoveNameAndLastnameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :name, :string
    remove_column :users, :lastname, :string
  end
end
