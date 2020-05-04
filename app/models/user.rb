class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #複数のユーザをフォローする関係を持つ
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #複数のユーザからフォローされる関係を持つ
  has_many :following, through: :active_relationships, source: :followed #複数のフォローするユーザを持つ
  has_many :followers, through: :passive_relationships, source: :follower #複数のフォローされるユーザを持つ

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
