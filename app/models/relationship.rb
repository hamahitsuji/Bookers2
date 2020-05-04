class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" #複数のフォローされるユーザに属す
  belongs_to :followed, class_name: "User" #複数のフォローするユーザに属す
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
