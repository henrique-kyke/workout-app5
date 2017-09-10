class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    params[:user_id] = current_user.id

    Friendship.create(friendship_params) unless current_user.follows_or_same?(friend)
  end

  def show
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises
  end

  private

  def friendship_params
    params.permit(:friend_id, :user_id)
  end
end
