# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tweets = Tweet.all.includes({ user: { icon_attachment: :blob } },
                                 { images_attachments: :blob }, :favorites, :comments, :retweets).order(created_at: 'DESC').page(params[:recommend])
    return unless current_user

    @followers_tweets = Tweet.includes({ user: { icon_attachment: :blob } },
                                       { images_attachments: :blob }, :favorites, :comments, :retweets).where(user_id: current_user.followers.pluck(:user_id)).page(params[:follow])
  end
end
