require 'rails_helper'

RSpec.describe "Tweets", type: :system do
  before do
    driven_by(:rack_test)
  end

  # ユーザーはウェウブサイトにサインアップできる　正常系
  scenario "user signs up on the website" do
    visit root_path
    click_link "新規登録"
    fill_in "Eメール", with: "sample-address@example.com"
    fill_in "Phone number", with: "070-1234-5678"
    fill_in "誕生日", with: "1930-01-01"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button "Sign up"

    expect(page).to have_content("本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。")

  end

  # ユーザーはWebサイトにサインアップできない　異常系
  scenario "user can't sign up on the website" do
    visit root_path
    click_link "新規登録"
    fill_in "Eメール", with: "sample-address@example.com"
    fill_in "Phone number", with: "070-1234-5678"
    fill_in "誕生日", with: nil
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_button "Sign up"

    expect(page).to have_content("誕生日を入力してください")
  end

  # ユーザーはウェブサイトにログインできる　正常系
  scenario "user logins on the website" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "Log in"

    expect(page).to have_content("ログインしました。")

  end

  # ユーザーはウェブサイトにログインできない　異常系
  scenario "user can't login on the website" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: nil
    fill_in "パスワード", with: user.password
    click_button "Log in"

    expect(page).to have_content("Eメールまたはパスワードが違います。")

  end

  # ユーザーは新しいツイートを作成できる 正常系
  scenario "user creates a new tweet" do
      user = FactoryBot.create(:user)

      visit root_path
      click_link "ログイン"
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      click_button "Log in"

      expect {
        fill_in "tweet[content]", with: 'サンプル投稿'
        click_button "ポストする"

        expect(page).to have_content "コンテンツを投稿しました。"
      }.to change(user.tweets, :count).by(1)
  end

    # ユーザーは新しいツイートを作成できない 異常系
    scenario "user can't create a new tweet" do
      user = FactoryBot.create(:user)

      visit root_path
      click_link "ログイン"
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      click_button "Log in"

      fill_in "tweet[content]", with: "jmgovmkso@mngasnmgko@angoasngoskngnwa[[;;lc@asdk@opgwegwajmgians@gomsrognaijghmelprjgmioesrjmgposdgjms@irjgo@eapkgmeiorgjerpojmhkodmhopbdmrgkgnaisormgoenhio@drekmgenmgheoprjnhiger@amghoksm"
      click_button "ポストする"

      expect(page).to have_content "投稿内容は140文字以内で入力してください"
  end
end 
