class CommentsController < ApplicationController
  before_action :set_comment,only:[:edit,:update,:destroy]
  # コメントを保存、投稿するためのアクション
  def create
    # Topicをパラメータの値から探し出し,Topicに紐づくcommentsとしてbuildする
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html {redirect_to topic_path(@comment.topic), notice:"コメントを編集しました！"}
        else
          format.html { render :edit }
        end
      end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js { render :index }  # JS形式でレスポンスを返す
      else
        format.html { render :new }
      end
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
    def set_comment
      @comment = Comment.find(params[:id])
    end
end
