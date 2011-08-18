module ApplicationHelper
  #1
  def new_answer_notification(user_id,user_name,question_id,question_title)
    content = "#{link_to user_name, user_path(:id => user_id)} has a new answer on your question #{link_to question_title, question_path(:id => question_id)}".html_safe
    content_tag(:div, 
            content_tag(:p, content), :class => "strong").html_safe
  end
  
  #6
  def new_comment_on_q(user_id,user_name,question_id,question_title)
    content = "#{link_to user_name, user_path(:id => user_id)} has a new comment on your question #{link_to question_title, question_path(:id => question_id)}".html_safe
    content_tag(:div, 
            content_tag(:p, content), :class => "strong").html_safe
  end
  
  #7
  def new_comment_on_a(user_id,user_name,question_id,answer)
    content = "#{link_to user_name, user_path(:id => user_id)} has a new comment on your answer #{link_to answer, question_path(:id => question_id)}".html_safe
    content_tag(:div, 
            content_tag(:p, content), :class => "strong").html_safe
  end
  
  #9 评 论 回 复 
  #def new_reply_comment(user_name,comment,question_title,answer)
  #  content = "has a new reply #{comment} on your comment on #{question_title}".html_safe
  #  content_tag(:div, 
  #          content_tag(:p, content), :class => "strong").html_safe
  #end
  
  def up_voted(obj, uid)
    upclass = 'vote-up-off '
    obj_name = obj.class.name.downcase
    upclass += 'vote-up-on' if $redis.sismember("#{obj_name[0].chr}:#{obj.id}.up_voter", uid)
		link_to('vote up', "/#{obj_name}s/#{obj.id}/votes/up",
		:remote => true,
		:id => "#{obj_name}_#{obj.id}_up_class",
		:class => upclass).html_safe
  end
  
  def down_voted(obj, uid)
    downclass = 'vote-down-off '
    obj_name = obj.class.name.downcase
    downclass += 'vote-down-on' if $redis.sismember("#{obj_name[0].chr}:#{obj.id}.down_voter", uid)
		link_to('vote down', "/#{obj_name}s/#{obj.id}/votes/down",
		:remote => true,
		:id => "#{obj_name}_#{obj.id}_down_class",
		:class => downclass).html_safe
  end
end
