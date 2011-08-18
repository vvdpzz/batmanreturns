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
    puts new_comments
    
    comment=hash[:content]
    @instance.update_attribute(:comments, new_comments)
    if old_comments.nil? 
      Resque.enqueue(NewCommentQueue, @instance_type, @instance, comment, current_user.id, current_user.realname, 0)
    else  
      Resque.enqueue(NewCommentQueue, @instance_type, @instance, comment, current_user.id, current_user.realname, 1)
      puts @instance_type
      puts @instance
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
