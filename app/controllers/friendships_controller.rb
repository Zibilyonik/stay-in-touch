class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @user = User.find(params[:user_id])
    @friendship = @user.friendships.build(friend_id: params[:friend_id], confirmed: false)
    @inverted = @user.inverted_friendships.find_by(user_id: params[:friend_id])
    if @friendship.save
      if @inverted
        @friendship.confirmed = true
        @inverted.confirmed = true
        @friendship.save!
        @inverted.save!
      end
      redirect_to user_path(@friendship.friend.id)
    else
      redirect_to users_path, alert: 'You cannot invite this person to a friendship.'
    end
  end

  def show
    @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @friendship1 = @user.friendships.find_by(user_id: @user.id, friend_id: params[:friend_id])
    @friendship2 = @user.inverse_friendships.find_by(user_id: params[:friend_id], friend_id: @user.id)
    if @friendship1 && !@friendship2
      @friendship1.destroy
      redirect_to users_path, alert: 'You cancelled your friend request.'
    elsif @friendship1 && @friendship2
      @friendship1.destroy
      @friendship2.destroy
      redirect_to users_path, notice: 'You deleted this person from your friends list.'
    else
      redirect_to users_path, alert: 'You cannot delete this person from your friends list.'
    end
  end
end
