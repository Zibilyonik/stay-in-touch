class Friendship < ApplicationRecord
  validates :user_id, uniqueness:
                                  { scope: :friend_id,
                                    message: 'You already have a request pending or are friends with this person' }
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
