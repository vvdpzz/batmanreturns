class NewCommentQueue
  @queue = :resque_call  
  def self.perform(sender_id, sender_name, description, instance, comment)
    if instance["answer"].nil?
      receiver_id = instance["question"]["user_id"]
      subject_id = instance["question"]["id"]                 # subject  =>  通 知 的 主 体
      subject_content = instance["question"]["title"]
      object_content = comment                                # object   =>  通 知 的 客 体
    else
      receiver_id = instance["answer"]["user_id"]
      subject_id = instance["answer"]["id"]
      subject_content = instance["answer"]["content"]
      sender_content = comment
    end
    
    notification = Notification.create(:receiver_id => receiver_id,
                                       :sender_id    => sender_id,
                                       :sender_name => sender_name,
                                       :description => description, 
                                       :subject_id => subject_id,
                                       :subject_content => subject_content,
                                       :object_content => object_content)
                                       
    Pusher["presence-channel_#{receiver_id}"].trigger('notification_created', (notification.serializable_hash).to_json)
  end  
end