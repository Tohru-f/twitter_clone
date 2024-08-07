class Tweet < ApplicationRecord
  belongs_to :user
  validates :comment, presence: true 
  has_many_attached :images
end
