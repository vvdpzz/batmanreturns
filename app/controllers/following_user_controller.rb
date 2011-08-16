class FollowingUserController < ApplicationController
  before_filter :load_following_user
  
  def following_user(id,name,aboutme,image_path)
    # 这 里 如 何
    @following_user = current_user.following_users.build(params[:favorite_question])
    follower_id = current_user.id
    following_id = 
    following_user_cache = $redis.sismember("user:#{user_id}.follows", following_id)
    FollowingUser.create(@following_user)
  end
  
  def undo
    @following_user.update_attributes(:following=>false)
  end

  protected
    def load_following_user
      @following_user = current_user.following_users.find(params[:id])
    end
end
