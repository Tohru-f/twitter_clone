# frozen_string_literal: true

class Follower < ApplicationRecord
  has_many :relations, dependent: :destroy
  has_many :users, through: :relations
end
