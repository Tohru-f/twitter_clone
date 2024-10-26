# frozen_string_literal: true

class MessagesController < ApplicationController
  # 誰がどのルームでどんな発言をしたかを管理する

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.create(user_id: current_user.id, content: params[:message][:content])

    if @message.save
      redirect_to room_path(@room), notice: 'メッセージが送信されました。'
    else
      redirect_to room_path(@room), alert: 'メッセージの送信に失敗しました。'
    end
  end
end
