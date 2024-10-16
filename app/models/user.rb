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
end
