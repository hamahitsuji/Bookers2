class ChatsController < ApplicationController
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.room_id = params[:room_id]
    @chat.save
  end

  def show
    @room = Room.find(params[:room_id])
    @chat = Chat.new
    @chat_logs = @room.chats
  end

  private
  def chat_params
    params.require(:chat).permit(:message)
  end
end

