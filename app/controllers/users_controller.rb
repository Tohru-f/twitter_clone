# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]

  def show
    @favorites = @user.favorites.includes(tweet: { images_attachments: :blob })
    @retweets = @user.retweets.includes(tweet: { images_attachments: :blob })
    @comments = @user.comments.includes(tweet: { images_attachments: :blob })
    @tweets = @user.tweets.includes(images_attachments: :blob)
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
    @favorites = @user.favorites.includes(tweet: { images_attachments: :blob })
    @retweets = @user.retweets.includes(tweet: { images_attachments: :blob })
    @comments = @user.comments.includes(tweet: { images_attachments: :blob })
    @tweets = @user.tweets.includes(images_attachments: :blob)
  end

  private

  def set_user
    return unless current_user

    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :birthday, :profile, :place, :website, :header, :icon)
  end
end
