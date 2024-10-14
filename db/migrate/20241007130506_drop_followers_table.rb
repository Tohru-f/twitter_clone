# frozen_string_literal: true

class DropFollowersTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :followers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
