module ApplicationHelper
  def new_answer_notification(user_name,question_id,question_title,answer)
    content = "#{link_to question_title, question_path(:id => question_id)} has a new answer #{answer} on your question #{question_title}".html_safe
    content_tag(:div, 
            content_tag(:p, content), :class => "strong").html_safe
  end
end
