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

  has_many :chats
  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def User.search(search, how_search)
    if how_search == "1"
      User.where(['name LIKE ?', "#{search}"])
    elsif how_search == "2"
      User.where(['name LIKE ?', "#{search}%"])
    elsif how_search == "3"
      User.where(['name LIKE ?', "%#{search}"])
    elsif how_search == "4"
      User.where(['name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def address
    [address_city, address_street].compact.join(',')
  end

  geocoded_by :address
  after_validation :geocode, if: :address_city_changed?

end

