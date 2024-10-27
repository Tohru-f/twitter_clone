# frozen_string_literal: true

class RoomsController < ApplicationController
  # 誰がどのルームに居るかを管理する
  def create
    @room = Room.create

    @entrie = @room.entries.build(user_id: params[:user_id])
    @entrie_login_user = @room.entries.build(user_id: current_user.id)

    if @entrie.save && @entrie_login_user.save
      redirect_to room_path(@room), notice: 'チャットルームに入りました。'
    else
      redirect_to home_index_path, alert: 'チャットルームの作成に失敗しました。'
    end
  end

  def index
    @rooms = Room.all.includes(:users, :messages)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.includes(:user)
    @message = Message.new
  end
end
