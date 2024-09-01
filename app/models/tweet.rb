# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { in: 1..140 }
  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy
end
