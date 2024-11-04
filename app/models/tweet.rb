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

  def create_notification_favorite!(current_user)
    # 既に「いいね」されているか検索 ?はプレースホルダでSQLインジェクションを防ぐ
    temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action = ? ', current_user.id,
                               user_id, id, 'favorite'])

    # いいねされていない場合のみに通知レコードを生成
    return if temp.present?

    notification = current_user.active_notifications.new(
      tweet_id: id,
      visited_id: user_id,
      action: 'favorite'
    )
    # 自分の投稿に対するいいねの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
    NotificationMailer.send_notification(notification, User.find(user_id), current_user).deliver_now
    # Rails.logger.debug("NotificationMailer呼び出し完了") # 追加してデバッグ
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人を全て取得して、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるので、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      tweet_id: id,
      comment_id:,
      visited_id:,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
    NotificationMailer.send_notification(notification, User.find(visited_id), current_user).deliver_now
  end

  def create_notification_retweet!(current_user)
    # 既に「リツイート」されているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and tweet_id = ? and action = ?', current_user.id,
                               user_id, id, 'retweet'])
    # リツイートされていない場合のみ通知レコードを生成
    return if temp.present?

    notification = current_user.active_notifications.new(
      tweet_id: id,
      visited_id: user_id,
      action: 'retweet'
    )
    # 自分の投稿に対するリツイートの場合は通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
    NotificationMailer.send_notification(notification, User.find(user_id), current_user).deliver_now
  end
end
