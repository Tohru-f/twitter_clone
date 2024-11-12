# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { in: 1..140 }
  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def check_notification(current_user)
    temp = current_user.active_notifications.where(visited_id: user_id, tweet_id: id, action: %w[favorite retweet])
    temp.present?
  end

  def create_notification!(current_user, action, user_id: nil, comment_id: nil)
    # いいね、若しくはリツイートされている場合は処理を終了する
    return if check_notification(current_user)

    notification = current_user.active_notifications.new(
      tweet_id: id,
      visited_id: user_id,
      comment_id:,
      action:,
      # 自分の投稿に対するいいね、リツイート、コメントの場合は通知済みとする
      checked: current_user.id == user_id
    )
    notification.save if notification.valid?
    NotificationMailer.send_notification(notification, User.find(user_id), current_user).deliver_now
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人を全て取得して、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      create_notification!(current_user, 'comment', user_id: temp_id['user_id'], comment_id:)
    end
    # まだ誰もコメントしていない場合は投稿者に通知を送る
    create_notification!(current_user, 'comment', user_id:, comment_id:) if temp_ids.blank?
  end
end
