# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @favorites = Favorite.includes(tweet: [:user, { images_attachments: :blob }]).where(user_id: @user.id)
    @retweets = Retweet.includes(tweet: [:user, { images_attachments: :blob }]).where(user_id: @user.id)
    @comments = Comment.includes(tweet: [:user, { images_attachments: :blob }]).where(user_id: @user.id)
    @tweets = Tweet.includes(:user, { images_attachments: :blob }).where(user_id: @user.id)

  end

  def update
    @user = User.find(params[:id])
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :birthday, :header, :icon)
  end
end
