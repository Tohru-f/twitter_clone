# frozen_string_literal: true

class CreateRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :relations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :follower, null: false, foreign_key: true

      t.timestamps
    end
  end
end
