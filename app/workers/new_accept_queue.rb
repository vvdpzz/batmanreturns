class NewAcceptQueue
  @queue = :resque_call  
  def self.perform(sender_name, description, question, answer)

    receiver_id = answer["answer"]["user_id"]
    sender_id = question["question"]["user_id"]
    subject_id = question["question"]["id"]
    subject_content = question["question"]["title"]
    object_id = answer["answer"]["id"]
    object_content = answer["answer"]["content"]
    
    notification = Notification.create(:receiver_id => receiver_id,
                                       :sender_id    => sender_id,
                                       :sender_name => sender_name,
                                       :description => description, 
                                       :subject_id => subject_id,
                                       :subject_content => subject_content,
                                       :object_id => object_id,
                                       :object_content => object_content)

    Pusher["presence-channel_#{receiver_id}"].trigger('notification_created', (notification.serializable_hash).to_json)
  end  
end