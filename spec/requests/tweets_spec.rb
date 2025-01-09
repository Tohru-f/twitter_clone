# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'GET /show' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet, user_id: user.id, content: 'サンプル投稿') }

    it 'responses correctly with the status of 200' do
      sign_in user
      get tweet_path(tweet)
      expect(response).to have_http_status(200)
    end

    it 'responses with a content of a tweet' do
      sign_in user
      get tweet_path(tweet)
      expect(response.body).to include tweet.content
    end
  end

  # サインアップできる 正常系
  describe 'Sign up' do
    context 'with valid parameters' do
      it 'creates a new user and redirects' do
        expect do
          post '/users',
               params: { user: { email: 'sample@gmail.com', phone_number: '050-7985-3125', birthday: '18000202', password: 'password',
                                 password_confirmation: 'password' } }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to(home_index_path)
        expect(response).to have_http_status(:redirect)
      end
    end

    # サインアップできない 異常系
    context 'with invalid parameters' do
      it 'does not create a new user and renders new' do
        expect do
          post '/users',
               params: { user: { email: 'sample@gmail.com', phone_number: nil, birthday: '18000202', password: 'password',
                                 password_confirmation: 'password' } }
        end.not_to change(User, :count)
        expect(response).not_to redirect_to(home_index_path)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'User' do
    let(:user) { FactoryBot.create(:user) }

    # 有効なユーザーの場合
    context 'with a valid user' do
      # ログインできる 正常系
      it 'logins correctly' do
        post new_user_session_path, params: { user: { email: user.email, password: user.password } }
        expect(response).to redirect_to(root_path)
      end
    end

    # 無効なユーザーの場合
    context 'with an invalid user' do
      # ログインできない 異常系
      it "doesn't login" do
        post new_user_session_path, params: { user: { email: user.email, password: nil } }
        expect(response).not_to redirect_to(root_path)
      end
    end
  end

  # 認証済みのユーザーとして
  context 'with an authenticated user' do
    let(:user) { FactoryBot.create(:user) }

    # 有効な属性値の場合
    context 'with valid attributes' do
      # 投稿を追加できること 正常系
      it 'adds a tweet' do
        # tweet_params = FactoryBot.attributes_for(:tweet).merge(user_id: @user.id, content: "サンプル投稿")
        tweet_params = FactoryBot.attributes_for(:tweet, user_id: user.id, content: 'サンプル投稿')
        sign_in user
        expect do
          post '/tweets', params: { tweet: tweet_params }
          # puts response.body if response.status != 200
          # puts @user.tweets.last.inspect
        end.to change(user.tweets, :count).by(1)
      end
    end

    # 無効な属性値の場合
    context 'with invalid attributes' do
      # 投稿を追加できないこと 異常系
      it 'does not add a tweet' do
        tweet_params = FactoryBot.attributes_for(:tweet).merge(user_id: user.id, content: nil)
        sign_in user
        expect do
          post '/tweets', params: { tweet: tweet_params }
        end.not_to change(user.tweets, :count)
      end
    end
  end
end
