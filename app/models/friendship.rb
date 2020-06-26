class Friendship < ApplicationRecord
  validates :user_id, uniqueness:
                                  { scope: :friend_id,
                                    message: 'You already have a request pending or are friends with this person' }
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm(user, friendship)
    @inverted = user.inverted_friendships.find_by(user_id: friendship.friend.id)
    return nil unless @inverted

    friendship.confirmed = true
    @inverted.confirmed = true
    @inverted.save
    save
  end
end
