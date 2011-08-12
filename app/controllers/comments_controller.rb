class CommentsController < ApplicationController
  before_filter :who_called_comment
  def create
    old_comments = @instance.comments
    
    hash = {}
    hash[:user_id] = current_user.id
    hash[:content] = params[:content]
    hash[:created_at] = Time.now
    
    if old_comments.nil? 
      old_comments = '' 
      new_comments = MultiJson.encode(hash)
    else
      new_comments = old_comments + ',' + MultiJson.encode(hash)
    end
    
    @instance.update_attribute(:comments, new_comments)
  end
  
  protected
  def who_called_comment
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return @instance = $1.classify.constantize.find(value)
      end
    end
  end
end
