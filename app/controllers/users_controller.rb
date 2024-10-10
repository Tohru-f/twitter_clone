# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[update show edit]
  before_action :set_followers, only: %i[unfollow]
  # ログインしていない場合、ログインページへ遷移させる
  before_action :authenticate_user!, only: %i[show edit update follow unfollow]

  def follow
    @relation = current_user.relations.build(follower_id: params[:id])
    if @relation.save
      redirect_to home_index_path, notice: 'フォローしました。'
    else
      redirect_to home_index_path, alert: 'フォローに失敗しました。'
    end
  end

  def unfollow
    @relation.destroy!
    redirect_to home_index_path, notice: 'フォローを解除しました。'
  end

  def show
    @favorites = @user.favorites.includes(tweet: [{ user: { icon_attachment: :blob } },
                                                  { images_attachments: :blob }, :favorites, :comments, :retweets]).select(:tweet_id).distinct
    @retweets = @user.retweets.includes(tweet: [{ user: { icon_attachment: :blob } },
                                                { images_attachments: :blob }, :comments, :favorites, :retweets]).select(:tweet_id).distinct
    @comments = @user.comments.includes(tweet: [{ user: { icon_attachment: :blob } },
                                                { images_attachments: :blob }, :favorites, :comments, :retweets]).select(:tweet_id).distinct
    @tweets = @user.tweets.includes({ user: { icon_attachment: :blob } }, { images_attachments: :blob }, :favorites,
                                    :comments, :retweets)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'プロフィールの内容を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def profile
    @user = User.find(params[:format])
    @favorites = @user.favorites.includes(tweet: [{ user: { icon_attachment: :blob } },
                                                  { images_attachments: :blob }, :favorites, :comments, :retweets]).select(:tweet_id).distinct
    @retweets = @user.retweets.includes(tweet: [{ user: { icon_attachment: :blob } },
                                                { images_attachments: :blob }, :comments, :favorites, :retweets]).select(:tweet_id).distinct
    @comments = @user.comments.includes(tweet: [{ user: { icon_attachment: :blob } },
                                                { images_attachments: :blob }, :comments, :favorites, :retweets]).select(:tweet_id).distinct
    @tweets = @user.tweets.includes({ user: { icon_attachment: :blob } }, { images_attachments: :blob }, :favorites,
                                    :comments, :retweets)
  end

  private

  def set_followers
    @relation = current_user.relations.find_by(follower_id: params[:id])
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :birthday, :profile, :place, :website, :header, :icon)
  end
end
