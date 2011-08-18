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
# 
# #$ redis.multi do
# #     
# #   Vote.all.each do |vote|
# #     question_id = vote.question_id
# #     answer_id = vote.answer_id
# #     user_id = vote.user_id
# #     
# #     if question_id
# #       if vote.vote == 1
# #         $redis.srem("q:#{question_id}.down_voter", user_id)
# #         $redis.sadd("q:#{question_id}.up_voter", user_id)
# #       else
# #         $redis.srem("q:#{question_id}.up_voter", user_id)
# #         $redis.sadd("q:#{question_id}.down_voter", user_id)
# #       end
# #     end
# #     
# #     if answer_id
# #       if vote.vote == 1
# #         $redis.srem("a:#{answer_id}.down_voter", user_id)
# #         $redis.sadd("a:#{answer_id}.up_voter", user_id)
# #       else
# #         $redis.srem("a:#{answer_id}.up_voter", user_id)
# #         $redis.sadd("a:#{answer_id}.down_voter", user_id)
# #       end
# #     end
# #   end
# #   
# # end
# 
# require 'open-uri'
# 
# class String
#   def is_numeric?
#     Float self rescue false
#   end
# end


# $redis.multi do
#     
#   Vote.all.each do |vote|
#     question_id = vote.question_id
#     answer_id = vote.answer_id
#     user_id = vote.user_id
#     
#     if question_id
#       if vote.vote == 1
#         $redis.srem("q:#{question_id}.down_voter", user_id)
#         $redis.sadd("q:#{question_id}.up_voter", user_id)
#       else
#         $redis.srem("q:#{question_id}.up_voter", user_id)
#         $redis.sadd("q:#{question_id}.down_voter", user_id)
#       end
#     end
#     
#     if answer_id
#       if vote.vote == 1
#         $redis.srem("a:#{answer_id}.down_voter", user_id)
#         $redis.sadd("a:#{answer_id}.up_voter", user_id)
#       else
#         $redis.srem("a:#{answer_id}.up_voter", user_id)
#         $redis.sadd("a:#{answer_id}.down_voter", user_id)
#       end
#     end
#   end
#   
# end

# 
# urls = []
# 
# url = "http://bbs.55bbs.com/forum-8-1.html"
# doc = Nokogiri::HTML(open(url))
# doc.css("th span a").each do |item|  
#   urls << item[:href]
# end
# 
# i = 0
# while i < urls.length do
#   if urls[i] == urls[i+1]
#     urls[i+1] = nil
#   end
#   i+=1
# end
# urls.compact!
# urls.each do |url|
#   a = url.split('-')
#   redis.zadd(a[1],a[2],a[2])
# end
# 
# redis.keys.each do |key|
#   a = redis.zrangebyscore(key, '-inf', '+inf')
#   if a[0] != a[-1]
#     puts "thread-#{key}-#{a[0]}-1.html"
#     puts "thread-#{key}-#{a[-1]}-1.html"
#     
#     s = a[0].to_i
#     e = a[-1].to_i
#     i=s
#     while i<= e do
#       url = "thread-#{key}-#{i}-1.html"
#       page = Nokogiri::HTML(open("http://bbs.55bbs.com/" + url))
#       page.css(".t_msgfont").each do |item|
#         puts item.text
#       end
#       i+=1
#     end
#   else
#     puts "thread-#{key}-#{a[0]}-1.html"
#     url = "thread-#{key}-#{a[0]}-1.html"
#     
#     page = Nokogiri::HTML(open("http://bbs.55bbs.com/" + url))
#     page.css(".t_msgfont").each do |item|
#       puts item.text
#     end
#   end
# end

# titleRedis = Redis.new(:host => '192.168.1.141', :port => 6379)
# 
# urls = []
# 
# 20.times do |i|
#   url = "http://bbs.55bbs.com/forum-8-#{i+1}.html"
#   doc = Nokogiri::HTML(open(url))
#   doc.css("th span a").each do |item|  
#     urls << item[:href]
#     if not item.text.is_numeric?
#       titleRedis.set(item[:href].split('-')[1], item.text)
#       puts item[:href].split('-')[1]
#     end
#   end
# end
# 
# i = 0
# while i < urls.length do
#   if urls[i] == urls[i+1]
#     urls[i+1] = nil
#   end
#   i+=1
# end
# urls.compact!
# urls.each do |url|
#   a = url.split('-')
#   $redis.zadd(a[1],a[2],a[2])
# end
# 
# puts "------------------------------------------------------------"
# 
# $redis.keys.each do |key|
#   a = $redis.zrangebyscore(key, '-inf', '+inf')
#   if a[0] != a[-1]
#         
#     s = a[0].to_i
#     e = a[-1].to_i
#     i=s
#     question_id = 0
#     while i<= e do
#       url = "thread-#{key}-#{i}-1.html"
#       page = Nokogiri::HTML(open("http://bbs.55bbs.com/" + url))
#       count = 0
#       title = titleRedis.get(key)
#       page.css(".t_msgfont").each do |item|
#         count+=1
#         if i==a[0].to_i and count ==1
#           question = Question.create(:title => title, :content => item.text, :user_id => 1)
#           question_id = question.id
#           puts "Create Question for #{question_id}"
#         else
#           Answer.create(:question_id => question_id, :user_id => 1, :content => item.text)
#           puts ".......... .......... add answer to #{question_id}"
#         end
#       end
#       i+=1
#     end
#   else
#     url = "thread-#{key}-#{a[0]}-1.html"
#     
#     page = Nokogiri::HTML(open("http://bbs.55bbs.com/" + url))
#     count = 0
#     title = titleRedis.get(key)
#     puts "one"
#     puts key
#     puts title
#     question_id = 0
#     page.css(".t_msgfont").each do |item|
#       count += 1
#       if count == 1
#         question = Question.create(:title => title, :content => item.text, :user_id => 1)
#         question_id = question.id
#         puts "Create Question for #{question_id}"
#       else
#         puts question_id
#         Answer.create(:question_id => question_id, :user_id => 1, :content => item.text)
#         puts ".......... .......... add answer to #{question_id}"
#       end
#     end
#   end
# end
