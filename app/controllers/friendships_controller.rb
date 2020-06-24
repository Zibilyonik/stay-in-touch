class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @user = User.find(params[:user_id])
    @friendship = Friendship.create(user_id: @user.id, friend_id: params[:friend_id])
    if @friendship.save
      @inverse = @user.inverse_friendships.find_by(friend_id: @user.id)
      if @inverse
        @friendship.confirmed = true
        @inverse.confirmed = true
        redirect_to users_path, notice: 'You accepted this person\'s friendship request.'
      else
        redirect_to users_path, notice: 'You invited this person to a friendship.'
      end
    else
      redirect_to users_path, alert: 'You cannot invite this person to a friendship.'
    end
  end

  def show
    @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @friendship1 = Friendship.find_by(user_id: @user.id, friend_id: params[:friend_id])
    @friendship2 = Friendship.find_by(user_id: params[:friend_id], friend_id: @user.id)
    if @friendship1 && !@friendship2
      @friendship1.destroy
      redirect_to users_path, notice: 'You cancelled your friend request.'
    elsif @friendship1 && @friendship2
      @friendship1.destroy
      @friendship2.destroy
      redirect_to users_path, notice: 'You deleted this person from your friends list.'
    else
      redirect_to users_path, alert: 'You cannot delete this person from your friends list.'
    end
  end
end
