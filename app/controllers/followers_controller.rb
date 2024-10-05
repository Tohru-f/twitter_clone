# frozen_string_literal: true

class FollowersController < ApplicationController
  before_action :set_followers, only: %i[destroy]
  # ログインしていない場合、ログインページへ遷移させる
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @follower = Follower.create(user_id: current_user.id)
    @relation = Relation.new(user_id: params[:user_id], follower_id: @follower.id)
    if @follower.save && @relation.save
      redirect_to home_index_path, notice: 'フォローしました。'
    else
      redirect_to home_index_path, alert: 'フォローに失敗しました。'
    end
  end

  def destroy
    @follower.destroy!
    redirect_to home_index_path, notice: 'フォローを解除しました。'
  end

  private

  def set_followers
    @follower = Follower.find(params[:id])
  end
end
