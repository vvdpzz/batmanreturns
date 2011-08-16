class NewAnswerCall
  @queue = :resque_call  
  def self.perform(reciever_id,user_id,user_name,question_id,question_title,question_content,answer_id,answer_content)
    Notification.create(:user_id => reciever_id,
                        :user    => user_id,
                        :user_name => user_name,
                        :question_id => question_id,
                        :question_title => question_title,
                        :question_content => question_content,
                        :answer_id => answer_id,
                        :answer_content => answer_content)
                        #:notification_type_id => 1)
  end  
end