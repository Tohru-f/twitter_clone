class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :place, :string
    add_column :users, :profile, :string
    add_column :users, :website, :string
  end
end
