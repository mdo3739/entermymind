class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.where(public: true).ranked.paginate(page: params[:page], per_page: 10)
    authorize @posts
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
    @user = @post.user
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build()
    authorize @post
  end

  def edit
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @topic = Topic.find(params[:topic_id])
    @post.topic = @topic
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to [@topic, @post], notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @post

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to [@topic, @post], notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    authorize @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_url(@topic.user), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @topic = Topic.find(params[:topic_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :topic, :public)
    end
end
