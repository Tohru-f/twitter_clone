# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # E-mail、電話番号、誕生日、名前、パスワードがあれば有効な状態であること。
  it "is valid with a email, phone_number, birthday and password" do
    user = User.new(
      email: "sawamura@example.com",
      phone_number: "090-8765-4321",
      birthday: "18430125",
      password: "password",
    )
    expect(user).to be_valid
  end

  # 電話番号が無ければ無効な状態であること
  it "is invalid without a phone_number" do
    user = User.new(phone_number: nil)
    user.valid?
    expect(user.errors[:phone_number]).to include("を入力してください")
  end

  # 生年月日が無ければ無効な状態であること
  it "is invalid without a birthday" do
    user = User.new(birthday: nil)
    user.valid?
    expect(user.errors[:birthday]).to include("を入力してください")
  end

  # メールアドレスが無ければ無効な状態であること
  it "is invalid without a email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    User.create(
      email: "tester@example.com",
      phone_number: "090-8765-4321",
      birthday: "18390927",
      name: "高杉 晋作",
      password: "password",
    )
    user = User.new(
      email: "tester@example.com",
      phone_number: "080-8765-4321",
      birthday: "18330811",
      name: "桂 小五郎",
      password: "password",
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

end
