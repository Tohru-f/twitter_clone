# frozen_string_literal: true

class ResetCountersForTweets < ActiveRecord::Migration[7.0]
  def up
    Tweet.find_each do |tweet|
      Tweet.reset_counters(tweet.id, :comments) # commentsのカウントをリセット
      Tweet.reset_counters(tweet.id, :favorites) # favoritesのカウントをリセット
    end
  end

  def down
    # 元に戻す処理は不要
  end
end
