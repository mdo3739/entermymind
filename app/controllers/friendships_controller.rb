class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:friend_id])
    if current_user.friends.include?(@friend)
      flash[:alert] = "#{@friend.username} is already on your list!"
      redirect_to :back
    else
      @friendship = current_user.friendships.build(friend_id: @friend.id)
      if @friendship.save
        flash[:notice] = "Added to your list"
        redirect_to :back
      else
        flash[:error] = "Didn't work. Try again?"
        redirect_to :back
      end
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      flash[:notice] = "Removed from your circle"
      redirect_to :back
    else
      flash[:error] = "Did not work. Try again."
      redirect_to :back
    end
  end
end
