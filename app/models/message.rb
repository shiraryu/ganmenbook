class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id
  def message_time
    created_at.try(:strftime,"%Y年%m月%d日 %H:%M:%S") #メッセージ未入力の際のバリデーションに対応した記載
  end
end
