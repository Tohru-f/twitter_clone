# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, counter_cache: :count_of_favorites
end
