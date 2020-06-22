class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      if Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id)
        redirect_to users_path, notice: 'You accepted this person\'s friendship request.'
      else
        redirect_to users_path, notice: 'You invited this person to a friendship.'
      end
    else
      redirect_to users_path, alert: 'You cannot invite this person to a friendship.'
    end
  end

  def destroy
    @friendship1 = Friendship.find_by(user_id: current_user.id, friend_id: params[:friend_id])
    @friendship2 = Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id)
    if @friendship1 && @friendship2
      @friendship1.destroy
      @friendship2.destroy
      redirect_to users_path, notice: 'You deleted this person from your friends list.'
    else
      redirect_to users_path, alert: 'You cannot delete this person from your friends list.'
    end
  end
  
  def cancel
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:friend_id])
    if @friendship1 
      @friendship1.destroy
      redirect_to users_path, notice: 'You cancelled your friend request.'
    else
      redirect_to users_path, alert: 'You cannot cancel your friend request.'
    end
  end
end
