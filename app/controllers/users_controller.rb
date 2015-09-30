class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if current_user && ((current_user == @user) || current_user.admin?)
      @topics = @user.topics
    else
      @topics = @user.topics.where(public: true)
    end
    @topic = @topics.first
    if @topic
      @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
    else
      @posts = []
    end
  end
end
