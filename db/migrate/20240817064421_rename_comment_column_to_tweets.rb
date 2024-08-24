# frozen_string_literal: true

class RenameCommentColumnToTweets < ActiveRecord::Migration[7.0]
  def change
    rename_column :tweets, :comment, :content
  end
end
