class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to users_path, notice: 'You invited this person to a friendship.'
    else
      redirect_to users_path, alert: 'You cannot invite this person to a friendship.'
    end
  end

  def destroy
    @friendship1 = current_user.friendships.find_by(user_id: params[:friend_id], friend_id: params[:user_id])
    @friendship1 = current_user.inverse_friendships.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    if @friendship1 && @friendship2
      @friendship1.destroy
      @friendship2.destroy
      redirect_to users_path, notice: 'You deleted this person from your friends list.'
    else
      redirect_to users_path, alert: 'You cannot delete this person from your friends list.'
    end
  end
end
