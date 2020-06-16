class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to user_path(current_user.id), notice: 'You invited this person to a friendship.'
    else
      redirect_to user_path(current_user.id), alert: 'You cannot invite this person to a friendship.'
    end
  end

  def destroy
  end
end
