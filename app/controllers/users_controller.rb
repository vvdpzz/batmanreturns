class UsersController < ApplicationController
  def follow
    following_user = User.find params[:id]
    if following_user
      follower_id = current_user.id
      followed_id = params[:id]
      if not is_in_redis
        $redis.sadd("user:#{current_user.id}.follows", params[:id])
      end
      if is_in_redis
        Resque.enqueue(NewFollowerQueue, followed_id,follower_id,current_user.realname)
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
  
  def is_in_redis
    $redis.sismember("user:#{current_user.id}.follows", params[:id])
  end
  
  def show
    @user = User.find params[:id]
  end
end
