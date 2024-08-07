# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    
    @tweets = Tweet.all.includes(:user ,{images_attachments: :blob}).order(created_at: "DESC").page(params[:page_1]).per(5)
    @followers_tweets = Tweet.includes(:user ,{images_attachments: :blob}).where(user_id: current_user.followers.pluck(:user_id)).page(params[:page_2]).per(5) if current_user
    
  end
  
end
