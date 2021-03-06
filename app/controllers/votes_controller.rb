class VotesController < ApplicationController
  before_action :load_post_and_vote

  def up_vote
    update_vote!(1)
    redirect_to :back
  end

  def down_vote
    update_vote!(-1)
    redirect_to :back
  end

  private

  def load_post_and_vote
    @post = Post.find(params[:post_id])
    authorize Vote.new
    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote!(new_value)
    if @vote
      @vote.update_attribute(:value, new_value)
    else
      @vote = current_user.votes.create(value: new_value, post: @post)
    end
  end
end