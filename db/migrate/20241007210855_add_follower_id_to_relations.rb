# frozen_string_literal: true

class AddFollowerIdToRelations < ActiveRecord::Migration[7.0]
  def change
    add_reference :relations, :follower, foreign_key: { to_table: :users }
  end
end
