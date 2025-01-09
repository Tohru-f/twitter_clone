# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    content { '' }
    user_id { '' }
    association :user
  end
end
