class CommentsController < ApplicationController
  before_filter :who_called_comment
  def create
    old_comments = @instance.comments
    new_comments = old_comments + ',' + MultiJson.encode([:comments])
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
