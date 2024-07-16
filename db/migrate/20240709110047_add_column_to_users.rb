# frozen_string_literal: true

class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :phone_number, null: false, default: ''
      t.date :birthday, null: false, default: ''
      t.string :name, null: false, default: ''
    end
  end
end
