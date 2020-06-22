class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id

  def friends
    friends_array = []
    friendships.each do |friendship|
      if inverse_friendships.find_by(user_id: friendship.friend_id, friend_id: friendship.user_id)
        friends_array << friendship.friend.name
      end
    end
    friends_array.compact
  end

  def pending_friends
    friendships.map{|friendship| friendship.friend }.compact
  end

  def friend_requests
    inverse_friendships.map{|friendship| friendship.user}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendships.build(friend_id: user.id)
  end

  def friend?(user)
    friends.include?(user.name)
  end

end
