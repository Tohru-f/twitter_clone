# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_user, only: %i[create]

  def index
    @tweets = Tweet.all.includes(user: { icon_attachment: :blob },
                                 images_attachments: :blob).order(created_at: 'DESC').page(params[:recommend])
    return unless current_user

    @followers_tweets = Tweet.includes(user: { icon_attachment: :blob },
                                       images_attachments: :blob).where(user_id: current_user.followers.pluck(:user_id)).page(params[:follow])
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = @user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to home_index_path, notice: 'コンテンツを投稿しました。'
    else
      Rails.logger.debug "TWEET ERRORS: #{@tweet.errors.full_messages.inspect}"
      # flash.now[:alert] = "コンテンツの投稿に失敗しました。"
      @tweets = Tweet.all.includes(:user,
                                   { images_attachments: :blob }).order(created_at: 'DESC').page(params[:recommend])
      @followers_tweets = Tweet.includes(:user,
                                         { images_attachments: :blob }).where(user_id: current_user.followers.pluck(:user_id)).page(params[:follow])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, images: [])
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
