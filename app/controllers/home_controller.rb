# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tweets = Tweet.all.includes(:user,
                                 { images_attachments: :blob }).order(created_at: 'DESC').page(params[:recommend])
    return unless current_user

    @followers_tweets = Tweet.includes(:user,
                                       { images_attachments: :blob }).where(user_id: current_user.followers.pluck(:user_id)).page(params[:follow])
  end
end
