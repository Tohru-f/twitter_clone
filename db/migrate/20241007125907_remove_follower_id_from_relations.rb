# frozen_string_literal: true

class RemoveFollowerIdFromRelations < ActiveRecord::Migration[7.0]
  def change
    remove_column :relations, :follower_id, :bigint
  end
end
