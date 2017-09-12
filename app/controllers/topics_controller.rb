class TopicsController < ApplicationController
  before_action :set_topic,only:[:edit,:update,:destroy]

  def index
    @topics = Topic.all
  end

  def new
    if params[:back]
      @picture = Picture.new(pictures_params)
    else
      @picture = Picture.new
    end
  end

  def created
    @picture = Picture.new(pictures_params)
    if @topic.save
        redirect_to topics_path,notice:"投稿しました"
      else
        render'new'
      end
  end

  def edit

  end

  def update
    if @topic.update(topics_params)
      redirect_to topics_path,notice:"編集しました"
    else
      render'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path,notice:"削除しました"
  end

  def confirm
    @topic = Topic.new(topics_params)
    render :new if @picture.invalid?
  end

  private
    def topics_params
      params.require(:topic).permit(:content)
    end
    def set_topic
      @topic = Topic.find(params[:id])
    end

end
