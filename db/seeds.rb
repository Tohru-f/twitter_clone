# frozen_string_literal: true

# # frozen_string_literal: true

# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
# user1 = User.create!(
#   email: 'ryoma@gmail.com',
#   phone_number: '090-1234-5678',
#   birthday: 18_360_103,
#   name: '坂本 竜馬',
#   password: 'password',
#   confirmed_at: Time.zone.today,
#   profile: '土佐脱藩郷士 北辰一刀流免許皆伝 海援隊隊長 薩長同盟の盟約に尽力',
#   place: '土佐藩(現高知県出身)',
#   website: 'https://www.google.co.jp'
# )
# user1.icon.attach(io: File.open(Rails.root.join('app/assets/images/Sakamoto_Ryoma.jpg')),
#                   filename: 'Sakamoto_Ryoma.jpg')
# user1.header.attach(io: File.open(Rails.root.join('app/assets/images/kumiaikakunikikyo.jpg')),
#                     filename: 'kumiaikakunikikyo.jpg')

# user2 = User.create!(
#   email: 'hanpeita@yahoo.co.jp',
#   phone_number: '070-1234-5678',
#   birthday: 18_291_024,
#   name: '武市 半平太',
#   password: 'password',
#   confirmed_at: Time.zone.today,
#   profile: '土佐藩白札郷士 鏡心明智流免許皆伝 土佐勤王党党首',
#   place: '土佐藩(現高知県出身)',
#   website: 'https://www.yahoo.co.jp'
# )
# user2.icon.attach(io: File.open(Rails.root.join('app/assets/images/Takechi_Hanpeita.jpg')),
#                   filename: 'Takechi_Hanpeita.jpg')
# user2.header.attach(io: File.open(Rails.root.join('app/assets/images/marunikakinohana.jpg')),
#                     filename: 'marunikakinohana.jpg')

# user3 = User.create!(
#   email: 'izo@hotmail.com',
#   phone_number: '080-1234-5678',
#   birthday: 18_380_214,
#   name: '岡田 以蔵',
#   password: 'password',
#   confirmed_at: Time.zone.today,
#   profile: '土佐藩郷士 鏡心明智流 勝海舟の護衛',
#   place: '土佐藩(現高知県出身)',
#   website: 'https://www.microsoft.com/ja-jp/'
# )
# user3.icon.attach(io: File.open(Rails.root.join('app/assets/images/Okada_Izo.jpg')), filename: 'Okada_Izo.jpg')
# user3.header.attach(io: File.open(Rails.root.join('app/assets/images/maruninarabikine.png')),
#                     filename: 'maruninarabikine.png')

# user4 = User.create!(
#   email: 'shintaro@mocha.ocn.ne.jp',
#   phone_number: '050-1234-5678',
#   birthday: 18_380_506,
#   name: '中岡 慎太郎',
#   password: 'password',
#   confirmed_at: Time.zone.today,
#   profile: '土佐藩郷士 陸援隊隊長 薩長同盟の盟約に尽力',
#   place: '土佐藩(現高知県出身)',
#   website: 'https://www.ocn.ne.jp'
# )
# user4.icon.attach(io: File.open(Rails.root.join('app/assets/images/Nakaoka_Shintaro.jpg')),
#                   filename: 'Nakaoka_Shintaro.jpg')
# user4.header.attach(io: File.open(Rails.root.join('app/assets/images/maruniwatanohana.gif')),
#                     filename: 'maruniwatanohana.gif')

# # Followerモデルを削除したので、新たにseedsでデータを投入する場合はRelationテーブルのデータ生成内容を作り直す必要がある

# # follower1 = Follower.create!(
# #   user_id: user2.id
# # )
# # Relation.create!(
# #   user_id: user1.id,
# #   follower_id: follower1.id
# # )

# # follower2 = Follower.create!(
# #   user_id: user1.id
# # )
# # Relation.create!(
# #   user_id: user2.id,
# #   follower_id: follower2.id
# # )

# # follower3 = Follower.create!(
# #   user_id: user3.id
# # )
# # Relation.create!(
# #   user_id: user1.id,
# #   follower_id: follower3.id
# # )

# # follower4 = Follower.create!(
# #   user_id: user4.id
# # )
# # Relation.create!(
# #   user_id: user1.id,
# #   follower_id: follower4.id
# # )

# # follower5 = Follower.create!(
# #   user_id: user2.id
# # )
# # Relation.create!(
# #   user_id: user4.id,
# #   follower_id: follower5.id
# # )

# User.all.ids.sort.each do |user_id|
#   Tweet.create!(
#     content: 'サンプル1',
#     user_id:
#   )
#   Tweet.create!(
#     content: 'サンプル2',
#     user_id:
#   )
#   tweet3 = Tweet.create!(
#     content: 'サンプル3',
#     user_id:
#   )
#   tweet3.images.attach(io: File.open(Rails.root.join('app/assets/images/BIG_TUNA.JPG')), filename: 'BIG_TUNA.JPG')
#   tweet4 = Tweet.create!(
#     content: 'サンプル4',
#     user_id:
#   )
#   tweet4.images.attach(io: File.open(Rails.root.join('app/assets/images/yellowtail_kingfish2.jpg')),
#                        filename: 'yellowtail_kingfish2.jpg')
#   Tweet.create!(
#     content: 'サンプル5',
#     user_id:
#   )
#   Favorite.create!(
#     tweet_id: Tweet.first.id,
#     user_id:
#   )
#   Retweet.create!(
#     tweet_id: Tweet.last.id,
#     user_id:
#   )
#   Comment.create!(
#     tweet_id: Tweet.first.id,
#     user_id:,
#     sentence: 'SEEDで投入したサンプル文'
#   )
# end

ActionMailer::Base.deliveries.clear if defined?(ActionMailer::Base)

def find_or_create_user(email, phone_number, birthday)
  User.find_by(email:) || User.create!(email:, phone_number:, birthday:,
                                       password: 'password')
end

def find_or_create_tweet(content, user)
  Tweet.find_by(content:, user:) || Tweet.create!(content:, user:)
end

user1 = find_or_create_user('sample@gmail.com', '050-1234-5678', '2000-01-01')
tweet1 = find_or_create_tweet('You are fired.', user1)

favorite1 = Favorite.create!(
  tweet_id: tweet1.id,
  user_id: user1.id
)
if (Rails.env.production? || Rails.env.development?) && !ENV['CI']
  favorite1.tweet.create_notification!(user1, 'favorite',
                                       user_id: favorite1.tweet.user.id)
end

user2 = find_or_create_user('apprentice@gmail.com', '070-1234-5678', '2000-12-01')
tweet2 = find_or_create_tweet('Enough!!', user2)

favorite2 = Favorite.create!(
  tweet_id: tweet2.id,
  user_id: user2.id
)
if (Rails.env.production? || Rails.env.development?) && !ENV['CI']
  favorite2.tweet.create_notification!(user2, 'favorite',
                                       user_id: favorite2.tweet.user.id)
end

user3 = find_or_create_user('rookie@gmail.com', '080-1234-5678', '2002-12-01')
tweet3 = find_or_create_tweet("I'm done.", user3)

retweet1 = Retweet.create!(
  tweet_id: tweet3.id,
  user_id: user3.id
)
if (Rails.env.production? || Rails.env.development?) && !ENV['CI']
  retweet1.tweet.create_notification!(user3, 'retweet',
                                      user_id: retweet1.tweet.user.id)
end

user4 = find_or_create_user('newface@gmail.com', '090-1234-5678', '2012-12-01')
tweet4 = find_or_create_tweet('You are welcome.', user4)

retweet2 = Retweet.create!(
  tweet_id: tweet4.id,
  user_id: user4.id
)
if (Rails.env.production? || Rails.env.development?) && !ENV['CI']
  retweet2.tweet.create_notification!(user4, 'retweet',
                                      user_id: retweet2.tweet.user.id)
end

Rails.logger.debug "ActionMailer::Base.smtp_settings: #{ActionMailer::Base.smtp_settings.inspect}"
Rails.logger.debug "Rails.env: #{Rails.env}"
Rails.logger.debug "ENV['CI']: #{ENV['CI']}"
