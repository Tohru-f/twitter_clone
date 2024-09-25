# frozen_string_literal: true

class AddCountOfCommentsAndFavoritesToTweets < ActiveRecord::Migration[7.0]
  # def change
  #   add_column :tweets, :count_of_comments, :integer, default: 0, null: false
  #   add_column :tweets, :count_of_favorites, :integer, default: 0, null: false
  # end

  change_table :tweets, bulk: true do |t|
    t.integer :count_of_comments, default: 0, null: false
    t.integer :count_of_favorites, default: 0, null: false
  end
end
