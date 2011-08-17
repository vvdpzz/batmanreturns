class NewCommentQueue
  @queue = :resque_call  
  def self.perform(type, object, comment, id, realname,reply)
    if type  == "question"
      reciever_id = object["question"]["user_id"]
      user_id = id
      user_name = realname
      question_id = object["question"]["id"]
      question_title = object["question"]["title"]
      comment_content =comment
      Notification.create(:user_id => reciever_id,
                          :user    => user_id,
                          :user_name => user_name,
                          :question_id => question_id,
                          :question_title => question_title,
                          :comment_content => comment_content,
                          :notification_type_id => 6)
      if reply == 1
       Notification.create(:user_id => reciever_id,
                           :user    => user_id,
                           :user_name => user_name,
                           :comment_content => comment_content,
                           :notification_type_id => 9)
      end
    elsif type == "answer"
      reciever_id = object["answer"]["user_id"]
      user_id = id
      user_name = realname
      answer_id = object["answer"]["id"]
      answer_content = object["answer"]["content"]
      comment_content =comment
      Notification.create(:user_id => reciever_id,
                          :user    => user_id,
                          :user_name => user_name,
                          :answer_id => answer_id,
                          :answer_content => answer_content,
                          :comment_content => comment_content,
                          :notification_type_id => 7)
      if reply == 1
        Notification.create(:user_id => reciever_id,
                            :user    => user_id,
                            :user_name => user_name,
                            :comment_content => comment_content,
                            :notification_type_id => 9)
      end
    end
  end  
end