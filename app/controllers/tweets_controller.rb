# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :set_user, only: %i[create]

  def show
    @tweet = Tweet.includes(images_attachments: :blob).find(params[:id])
    @comments = @tweet.comments.includes(user: { icon_attachment: :blob }, images_attachments: :blob)
    @replies = {}
    @comments.each do |comment|
      @replies[comment.id] = Comment.where(parent_id: comment.id) if Comment.where(parent_id: comment.id).present?
    end
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
      flash.now[:alert] = 'コンテンツの投稿に失敗しました。'
      @tweets = Tweet.all.includes(:user,
                                   { images_attachments: :blob }).order(created_at: 'DESC').page(params[:recommend])
      @followers_tweets = Tweet.includes(:user,
                                         { images_attachments: :blob }).where(user_id: current_user.followers.pluck(:user_id)).page(params[:follow])
      render template: 'home/index', status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :content, images: [])
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
