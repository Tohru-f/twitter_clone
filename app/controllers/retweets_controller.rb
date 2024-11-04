# frozen_string_literal: true

class RetweetsController < ApplicationController
  before_action :set_retweet, only: %i[destroy]
  # ログインしていなければ、ログインページへリダイレクト
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    # buildメソッドはnewとは異なり、関連づけられたインスタンスを作成できる
    @retweet = current_user.retweets.build(tweet_id: params[:tweet_id])
    tweet = Tweet.find(params[:tweet_id])
    if @retweet.save
      tweet.create_notification_retweet!(current_user)
      redirect_to home_index_path
    else
      redirect_to home_index_path, alert: 'リポストに失敗しました。'
    end
  end

  def destroy
    @retweet.destroy!
    redirect_to home_index_path
  end

  private

  def set_retweet
    @retweet = Retweet.find(params[:id])
  end
end
