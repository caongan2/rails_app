class AddColumnToUserTable < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :integer, default: nil
    add_column :users, :address, :string, default: nil
  end
end
