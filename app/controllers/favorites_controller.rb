# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[destroy]

  def create
    if current_user.present?
      @favorite = Favorite.new
      @favorite.user_id = current_user.id
      @favorite.tweet_id = params[:tweet_id]
      if @favorite.save
        redirect_to home_index_path
      else
        redirect_to home_index_path, alert: 'お気に入りの保存に失敗しました。'
      end
    else
      flash[:alert] = 'ログインしてください。'
      # logger.debug "Flash alert: #{flash[:alert]}"
      @tweets = Tweet.all.includes(:user,
                                   { images_attachments: :blob }).order(created_at: 'DESC').page(params[:recommend])
      redirect_to home_index_path
    end
  end

  def destroy
    if current_user.present?
      @favorite.destroy!
      redirect_to home_index_path
    else
      flash.now[:alert] = 'ログインしてください。'
      @tweets = Tweet.all.includes(:user,
                                   { images_attachments: :blob }).order(created_at: 'DESC').page(params[:recommend])
      render template: 'home/index'
    end
  end

  private

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end
end
