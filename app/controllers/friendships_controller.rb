class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added to your list"
      redirect_to :back
    else
      flash[:error] = "Didn't work. Try again?"
      redirect_to :back
    end
  end
end
