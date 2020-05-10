class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id) #自分が持つuser_roomの全てのroom_idを抽出
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms) #自分が持つuser_roomと同じroom_idを持つ相手のuser_room

    unless user_rooms.nil?
      @room = user_rooms.room #相手と同じroomを持っている場合は、そのroomを返す
    else
      @room = Room.new #相手と同じroomを持っていない場合は、新しく作り、それに対応する中間テーブル（user_room）も２つ作る
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end

