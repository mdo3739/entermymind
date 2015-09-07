class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @topics = @user.topics
    @topic = @topics.first
  end
end
