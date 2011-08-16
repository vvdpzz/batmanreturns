class RelationshipController < ApplicationController
  before_filter :load_following_user
  
  def follow
    following_user = User.find params[:id]
    if following_user
      follower_id = current_user.id
      followed_id = params[:id]
      followed_user_cache = $redis.sismember("user:#{user_id}.follows", following_id)
    end
  end
  
  def undo
    @following_user.update_attributes(:following=>false)
  end

  protected
    def load_following_user
      @following_user = current_user.relationships.find(params[:id])
    end
end
