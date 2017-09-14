class Topic < ActiveRecord::Base
  validates:content,presence:true,length:{maximum: 350}
  validates:topicimage,presence:true

  mount_uploader:topicimage,TopicUploader  # carrierwave用の設定(modelとアップローダーの紐付け)

  belongs_to :user
  has_many :comments,dependent: :destroy  #CommentモデルのAssociation設定

end
