class Room < ApplicationRecord
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :chats

  def join(user_id)
    self.user_rooms.create(user_id: user_id)
  end
end
