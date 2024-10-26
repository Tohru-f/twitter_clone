# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries # これを入れることでroom.usersといった使い方が可能になる
  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :entries

  validate :room_user_limit

  def room_user_limit
    return unless entries.size >= 2

    errors.add(:room, 'このチャットルームには既に２人のユーザーが参加しています。')
  end
end
