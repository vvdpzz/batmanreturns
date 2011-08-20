class UsersController < ApplicationController
  def follow
    following_user = User.find params[:id]
    puts following_user
    if following_user
      follower_id = current_user.id
      followed_id = params[:id]
      if not following_user.has_relationship(current_user.id)
        $redis.sadd("user:#{current_user.id}.follows", params[:id])
      end
      if following_user.has_relationship(current_user.id)
        in_relationship = User.where(:follower_id => follower_id,:followed_id => followed_id)
        if in_relationship
          current_user.relationships.create(:follower_id => follower_id,:followed_id => followed_id)
        end
      if is_in_redis
        description = APP_CONFIG["notice_follow_user"]
        Resque.enqueue(NewFollowerQueue, followed_id, follower_id, current_user.realname, description)
      end
    end
  end
  
  def unfollow
    following_user = User.find params[:id]
    if following_user
      follower_id = current_user.id
      followed_id = params[:id]
      if following_user.has_relationship(current_user.id)
        $redis.serm("user:#{current_user.id}.follows", params[:id])
      end
      current_user.relationships.update_arributes(:following => false)
    end
  end
  
  def show
    @user = User.find params[:id]
  end
  
end
