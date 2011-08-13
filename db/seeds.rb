User.create(:username => 'xxd', :realname => '薛晓东', :email => 'xxd@gmail.com', :password => 'xxdxxd')
User.create(:username => 'vvdpzz', :realname => '陈振宇', :email => 'vvdpzz@gmail.com', :password => 'vvdpzz')
User.create(:username => 'tzzzoz', :realname => '喻柏程', :email => 'tzzzoz@gmail.com', :password => 'tzzzoz')

Question.create(:user_id => 1, :title => "This is the first question.", :content => "This is a content")
Question.create(:user_id => 2, :title => "This is the second question.", :content => "This is a content")
Question.create(:user_id => 3, :title => "This is the third question.", :content => "This is a content")