User.create(:username => 'xxd', :realname => '薛晓东', :email => 'xuexiaodong79@gmail.com', :password => 'xxdxxd')
User.create(:username => 'vvdpzz', :realname => '陈振宇', :email => 'vvdpzz@gmail.com', :password => 'vvdpzz')
User.create(:username => 'tzzzoz', :realname => '喻柏程', :email => 'tzzzoz@gmail.com', :password => 'tzzzoz')

Question.create(:user_id => 1, :title => "This is the first question.", :content => "This is a content")
Question.create(:user_id => 2, :title => "This is the second question.", :content => "This is a content")
Question.create(:user_id => 3, :title => "This is the third question.", :content => "This is a content")

NotificationType.create(:notification =>"问题有新答案")
NotificationType.create(:notification =>"问题被投票")
NotificationType.create(:notification =>"问题被接受")
NotificationType.create(:notification =>"答案被投票")
NotificationType.create(:notification =>"答案被接受")
NotificationType.create(:notification =>"问题被评论")
NotificationType.create(:notification =>"答案被评论")
NotificationType.create(:notification =>"用户被关注")
NotificationType.create(:notification =>"评论有回复")

$redis.multi do
    
  Vote.all.each do |vote|
    question_id = vote.question_id
    answer_id = vote.answer_id
    user_id = vote.user_id
    
    if question_id
      if vote.vote == 1
        $redis.srem("q:#{question_id}.down_voter", user_id)
        $redis.sadd("q:#{question_id}.up_voter", user_id)
      else
        $redis.srem("q:#{question_id}.up_voter", user_id)
        $redis.sadd("q:#{question_id}.down_voter", user_id)
      end
    end
    
    if answer_id
      if vote.vote == 1
        $redis.srem("a:#{answer_id}.down_voter", user_id)
        $redis.sadd("a:#{answer_id}.up_voter", user_id)
      else
        $redis.srem("a:#{answer_id}.up_voter", user_id)
        $redis.sadd("a:#{answer_id}.down_voter", user_id)
      end
    end
  end
  
end