class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #
  #引数としてtopic追加
  def sendmail_topic(topic)
    @greeting = "Hi"
      @topic = topic

      mail to: "@topic.email",
        subject:'[Ganmenbook]Topicが投稿されました'
  end
end
