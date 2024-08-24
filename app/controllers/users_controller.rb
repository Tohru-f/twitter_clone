# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @favorites = @user.favorites.includes(tweet: { images_attachments: :blob })
    @retweets = @user.retweets.includes(tweet: { images_attachments: :blob })
    @comments = @user.comments.includes(tweet: { images_attachments: :blob })
    @tweets = @user.tweets.includes(images_attachments: :blob)
  end

  def update
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :birthday, :header, :icon)
  end
end
