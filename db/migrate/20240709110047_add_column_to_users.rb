class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :string, null: false
    add_column :users, :birthday, :date, null: false
    add_column :users, :name, :string, null: false, default: ""
  end
end
