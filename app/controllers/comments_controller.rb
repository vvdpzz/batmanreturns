class CommentsController < ApplicationController
  before_filter :who_called_comment
  
  def new
  end
  
  def create
    old_comments = @instance.comments
    
    hash = {}
    hash[:user_id] = current_user.id
    hash[:realname] = current_user.realname
    hash[:content] = params[:content]
    hash[:created_at] = Time.now
    
    if old_comments.nil? 
      old_comments = '' 
      new_comments = MultiJson.encode(hash)
    else
      new_comments = old_comments + ',' + MultiJson.encode(hash)
    end
    
    comment = hash[:content]
    
    description = APP_CONFIG["notice_comment_#{@instance_type}"]

    if @instance.update_attribute(:comments, new_comments)
      Resque.enqueue(NewCommentQueue, current_user.id, current_user.realname, description, @instance, comment)
    end
  end
  
  protected
  def who_called_comment
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @instance = $1.classify.constantize.find(value)
        @instance_type = $1
      end
    end
  end
end
