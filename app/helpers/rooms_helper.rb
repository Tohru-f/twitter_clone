# frozen_string_literal: true

module RoomsHelper
  def check_rooms(tweet_user)
    Room.joins(:entries).where(entries: { user_id: [current_user.id,
                                                    tweet_user.id] }).group('rooms.id').having('COUNT(entries.id) = 2').first
  end
end
