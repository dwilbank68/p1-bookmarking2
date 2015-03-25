class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
    @current_user = current_user
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
    @current_user = current_user
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to :back, notice: 'Topic was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @topic.destroy
      redirect_to :back
    else
      redirect_to :back, notice: 'Topic cannot be destroyed. Still has bookmarks.'
    end
  end

  private

    def set_topic
      @topic = Topic.find(params[:id])
    end


    def topic_params
      params.require(:topic).permit(:name)
    end
end
