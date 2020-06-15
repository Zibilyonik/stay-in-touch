class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    @friendship.save!
  end

  def destroy
  end
end
