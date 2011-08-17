class RelationshipController < ApplicationController
  before_filter :load_following_user
  
  def follow
    following_user = User.find params[:id]
    if following_user
      follower_id = current_user.id
      followed_id = params[:id]
      is_in_redis = $redis.sismember("user:#{current_user.id}.follows", params[:id])
      if not is_in_redis
        $redis.sadd("user:#{current_user.id}.follows", params[:id])
      end
    end
  end
  
  def undo
    following_user = User.find params[:id]
    if following_user
      follower_id = current_user.id
      followed_id = params[:id]
      $redis.serm("user:#{current_user.id}.follows", params[:id])
      current_user.relationships.update_attributes(:following=>false)
  end

  protected
    def load_following_user
      @following_user = current_user.relationships.find(params[:id])
    end
end
