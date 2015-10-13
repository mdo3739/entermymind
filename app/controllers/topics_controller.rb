class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = current_user.topics
    authorize @topics
    @user = current_user



  end

  # GET /topics/new
  def new
    @topic = Topic.new
    authorize @topic
  end

  # GET /topics/1/edit
  def edit
    authorize @topic
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    authorize @topic
    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_path, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    authorize @topic
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topics_path, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { redirect_to :back }
        format.json { redirect_to :back, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:name, :user_id, :public, :posts_order, :description)
    end

    def set_posts_order_attribute(order)
      @topic = Topic.find(params[:topic_id])
      authorize @topic
      if @topic.update_attributes(posts_order: order)
        flash[:notice] = "Success!"
        redirect_to :back
      else
        flash[:error] = "Oh noo.."
        redirect_to :back
      end
    end

end
