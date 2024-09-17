# frozen_string_literal: true

class CommentsController < ApplicationController
  def show
    @comment = Comment.includes([:images_attachments]).find(params[:id])
    @tweet = Tweet.find_by(id: @comment.tweet_id)
    return if Comment.where(parent_id: @comment.id).blank?

    @comments = Comment.includes(user: { icon_attachment: :blob },
                                 images_attachments: :blob).where(parent_id: @comment.id)
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.tweet_id = params[:tweet_id]
    @comment.parent_id = params[:id] if params[:id].present? && Comment.exists?(params[:id]) # 親コメントに対して返信する場合
    if @comment.save
      redirect_to home_index_path, notice: 'コメントを投稿しました。'
    else
      flash.now[:alert] = 'コンテンツの投稿に失敗しました。'
      @tweets = Tweet.all.includes(:user,
                                   { images_attachments: :blob }).order(created_at: 'DESC').page(params[:recommend])
      @followers_tweets = Tweet.includes(:user,
                                         { images_attachments: :blob }).where(user_id: current_user.followers.pluck(:user_id)).page(params[:follow])
      render template: 'home/index', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:sentence, images: [])
  end
end
