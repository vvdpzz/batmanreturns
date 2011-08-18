class NewFollowerQueue
  @queue = :resque_call  
  def self.perform(followed_id,follower_id,follower_name)
    reciever_id = followed_id
    user_id = follower_id
    user_name = follower_name
    Notification.create(:user_id => reciever_id,
                        :user    => user_id,
                        :user_name => user_name,
                        :notification_type_id => 8)
  end  
end