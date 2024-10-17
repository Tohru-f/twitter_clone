# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy list]
  before_action :set_bookmark, only: %i[destroy]

  def create
    @bookmark = current_user.bookmarks.build(tweet_id: params[:tweet_id])

    if @bookmark.save
      redirect_to home_index_path, notice: '投稿をブックマークしました。'
    else
      redirect_to home_index_path, alert: '投稿のブックマークに失敗しました。'
    end
  end

  def destroy
    @bookmark.destroy!

    redirect_to home_index_path, notice: 'ブックマークを解除しました。'
  end

  def list
    @bookmarks = current_user.bookmarks.includes(tweet: [{ images_attachments: :blob }, :comments, :retweets,
                                                         :favorites])
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
