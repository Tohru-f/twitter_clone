# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user1 = User.create!(
  email: 'sample1@gmail.com',
  phone_number: '090-1234-5678',
  birthday: 20_240_728,
  name: 'sample1',
  password: 'password',
  confirmed_at: Time.zone.today
)
user2 = User.create!(
  email: 'sample2@yahoo.co.jp',
  phone_number: '070-1234-5678',
  birthday: 20_240_707,
  name: 'sample2',
  password: 'password',
  confirmed_at: Time.zone.today
)
user3 = User.create!(
  email: 'sample3@hotmail.com',
  phone_number: '080-1234-5678',
  birthday: 20_240_813,
  name: 'sample3',
  password: 'password',
  confirmed_at: Time.zone.today
)
user4 = User.create!(
  email: 'sample4@mocha.ocn.ne.jp',
  phone_number: '050-1234-5678',
  birthday: 20_240_610,
  name: 'sample4',
  password: 'password',
  confirmed_at: Time.zone.today
)

follower1 = Follower.create!(
  user_id: user2.id
)
Relation.create!(
  user_id: user1.id,
  follower_id: follower1.id
)

follower2 = Follower.create!(
  user_id: user1.id
)
Relation.create!(
  user_id: user2.id,
  follower_id: follower2.id
)

follower3 = Follower.create!(
  user_id: user3.id
)
Relation.create!(
  user_id: user1.id,
  follower_id: follower3.id
)

follower4 = Follower.create!(
  user_id: user4.id
)
Relation.create!(
  user_id: user1.id,
  follower_id: follower4.id
)

follower5 = Follower.create!(
  user_id: user2.id
)
Relation.create!(
  user_id: user4.id,
  follower_id: follower5.id
)

# user1.followers << user2
# user1.followers << user3
# user1.save

# user2.followers << user1
# user2.followers << user3
# user2.save

User.all.ids.sort.each do |user_id|
  Tweet.create!(
    comment: 'サンプル1',
    user_id:
  )
  Tweet.create!(
    comment: 'サンプル2',
    user_id:
  )
  tweet3 = Tweet.create!(
    comment: 'サンプル3',
    user_id:
  )
  tweet3.images.attach(io: File.open(Rails.root.join('app/assets/images/BIG_TUNA.JPG')), filename: 'BIG_TUNA.JPG')
  tweet4 = Tweet.create!(
    comment: 'サンプル4',
    user_id:
  )
  tweet4.images.attach(io: File.open(Rails.root.join('app/assets/images/yellowtail_kingfish2.jpg')),
                       filename: 'yellowtail_kingfish2.jpg')
  Tweet.create!(
    comment: 'サンプル5',
    user_id:
  )
end
