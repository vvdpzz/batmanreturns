class UsersController < ApplicationController
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
  
  def unfollow
    following_user = User.find params[:id]
    if following_user
      follower_id = current_user.id
      followed_id = params[:id]
      $redis.serm("user:#{current_user.id}.follows", params[:id])
    end
  end
  
  def show
    @user = User.find params[:id]
  end
end
