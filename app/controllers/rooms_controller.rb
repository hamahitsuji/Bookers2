class RoomsController < ApplicationController
  def create
    @room = Room.create
    @room.join(current_user.id)
    @room.join(params[:user_id])
    redirect_to room_chats_path(@room)
  end

end
