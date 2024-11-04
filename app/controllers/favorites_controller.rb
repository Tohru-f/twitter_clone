# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[destroy]
  # ログインしていなければ、ログインページへリダイレクト
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    # buildメソッドはnewメソッドと違い関連付けたインスタンスを生成できる
    @favorite = current_user.favorites.build(tweet_id: params[:tweet_id])
    tweet = Tweet.find(params[:tweet_id])
    if @favorite.save
      tweet.create_notification_favorite!(current_user)
      redirect_to home_index_path
    else
      redirect_to home_index_path, alert: 'お気に入りの保存に失敗しました。'
    end
  end

  def destroy
    @favorite.destroy!
    redirect_to home_index_path
  end

  private

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end
end
