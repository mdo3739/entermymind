class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    authorize @comment
  end

  # GET /comments/1/edit
  def edit
    authorize @comment
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment.post = @post
    authorize @comment
    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@topic, @post], notice: 'Comment was successfully created.' }
        format.json { redirect_to [@topic, @post], status: :created, location: @comment }
        format.js
      else
        format.html { redirect_to [@topic, @post] }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    authorize @comment
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@post.topic, @post], notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    authorize @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to [@post.topic, @post], notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      @post = Post.find(params[:post_id])
      @topic = @post.topic
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id)
    end
end
