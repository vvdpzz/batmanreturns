class NewAnswerCall
  @queue = :resque_call  
  def self.perform(question, answer, realname)
    # 放 在 这 里 获 取 这 些 变 量，，也 可 以 提 高 效 率
    reciever_id = question["question"]["user_id"]
    user_id = answer["answer"]["user_id"]
    user_name = realname
    question_id = question["question"]["id"]
    question_title = question["question"]["title"]
    question_content = question["question"]["content"]
    answer_id = answer["answer"]["id"]
    answer_content = answer["answer"]["content"]
    
    notification = Notification.create(:user_id => reciever_id,
                        :user    => user_id,
                        :user_name => user_name,
                        :question_id => question_id,
                        :question_title => question_title,
                        :question_content => question_content,
                        :answer_id => answer_id,
                        :answer_content => answer_content,
                        :notification_type_id => 1)
    
    value = new_answer_notification(notification.user_name, notification.question_id, notification.question_title, notification.answer_content)

    Pusher["presence-channel_#{current_user.id}"].trigger('notification_created', value)
  end  
end