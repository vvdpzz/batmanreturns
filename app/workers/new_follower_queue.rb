class NewFollowerQueue
  @queue = :resque_call  
  def self.perform(receiver_id, sender_id, sender_name, description)
    
    notification = Notification.create(:receiver_id => receiver_id,
                                       :sender_id    => sender_id,
                                       :sender_name => sender_name,
                                       :description => description)

    Pusher["presence-channel_#{receiver_id}"].trigger('notification_created', (notification.serializable_hash).to_json)
  end
end