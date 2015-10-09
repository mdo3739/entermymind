class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if current_user && ((current_user == @user) || current_user.admin?)
      if params[:search]
        @topics = @user.topics.search(params[:search], @user)
        @topics.compact! if @topics.include?(nil)
      else
        @topics = @user.topics
      end
    else
      @topics = @user.topics.where(public: true)
    end
  end
end