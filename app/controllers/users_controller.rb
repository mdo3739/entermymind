class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if current_user && ((current_user == @user) || current_user.admin?)
      @topics = @user.topics.search(params[:search], @user)
    else
      @topics = @user.topics.where(public: true).search(params[:search], @user)
    end
  end
end