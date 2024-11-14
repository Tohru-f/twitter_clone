# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, counter_cache: :count_of_comments
  belongs_to :parent, class_name: 'Comment', optional: true # 親コメント(返信先) Nillも許容
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy, inverse_of: :comment # 返信
  validates :sentence, presence: true, length: { in: 1..140 }
  has_many_attached :images
  has_many :notifications, dependent: :destroy
end
