# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[github]
  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_many :relations, dependent: :destroy
  has_many :following, through: :relations, source: :follower

  has_many :passive_relations, class_name: 'Relation', foreign_key: :follower_id, dependent: :destroy,
                               inverse_of: :follower
  has_many :followers, through: :passive_relations, source: :user

  has_one_attached :icon
  has_one_attached :header
  has_many :tweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries # これを入れることでuser.roomsといった使い方が可能になる
  has_many :messages, dependent: :destroy

  # 自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy,
                                  inverse_of: :visitor
  # 相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy,
                                   inverse_of: :visited

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.phone_number = '00000000000'
      user.birthday = '1984-01-01'

      if user.persisted? || auth.provider == 'github'
        user.skip_confirmation! if auth.provider == 'github'
        user.save
      end
    end
  end

  def create_notification_follow!(current_user)
    temp = current_user.active_notifications.where(visited_id: id, action: 'follow')
    return if temp.present?

    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
    )
    # 自分で自分のフォローはしない・できないので、current_user.id == user_idの判別は不要
    notification.save if notification.valid?
    NotificationMailer.send_notification(notification, User.find(id), current_user).deliver_now
  end
end
