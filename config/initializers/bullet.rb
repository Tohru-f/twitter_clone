# frozen_string_literal: true

if defined?(Bullet)
  Bullet.enable = true
  Bullet.alert = true
  Bullet.bullet_logger = true
  Bullet.rails_logger = true
  Bullet.add_footer = true

  Bullet.add_safelist type: :n_plus_one_query, class_name: 'Tweet', association: :user

  Bullet.add_safelist type: :unused_eager_loading, class_name: 'Tweet', association: :user
end
