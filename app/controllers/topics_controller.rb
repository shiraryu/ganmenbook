class TopicsController < ApplicationController
  before_action :authenticate_user!        #ログイン有無のチェック
  before_action :set_topic,only:[:show,:edit,:update,:destroy]

  def index
    @topics = Topic.all
  end

  def show
    @comment = @topic.comments.build   # 入力フォーム用インスタンス
    @comments = @topic.comments        # 一覧用インスタンス
  end

  def new
    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.new(topics_params)
    @topic.user_id = current_user.id      #contentと一緒にuser_idも保存されるようにする*/
    if params[:cache]
      @topic.topicimage.retrieve_from_cache! params[:cache][:topicimage]
    end
    if @topic.save
        redirect_to topics_path,notice:"投稿しました"
        NoticeMailer.sendmail_topic(@topic).deliver      #Mailer呼び出し
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
      render :new if @topic.invalid?
  end

  private
  def topics_params
    # topicimageを保存する時に、確認画面で一時的にキャッシュしたものを掘り出して値にセットし、保存
    params.require(:topic).permit(:content,:topicimage,:topicimage_cache)
  end
    def set_topic
      @topic = Topic.find(params[:id])
    end

end
