class NewAcceptQueue
  @queue = :resque_call  
  def self.perform(question, id, realname)
    reciever_id = question["question"]["user_id"]
    user_id = id
    user_name = realname
    question_id = question["question"]["id"]
    question_title = question["question"]["title"]
    answer_id = question["question"]["accept_a_id"]
    Notification.create(:user_id => reciever_id,
                        :user    => user_id,
                        :user_name => user_name,
                        :question_id => question_id,
                        :question_title => question_title,
                        :answer_id => answer_id,
                        :notification_type_id => 5)
  end  
end