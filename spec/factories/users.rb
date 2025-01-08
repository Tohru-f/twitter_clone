FactoryBot.define do
  factory :user do
    email { "tester@example.com" }
    phone_number { "050-1192-1414" }
    birthday { "18000101" }
    name { "幕末 三太郎" }
    password { "password" }
    confirmed_at { Time.now }
    icon { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'person.png'), 'image/png') }
  end
end
