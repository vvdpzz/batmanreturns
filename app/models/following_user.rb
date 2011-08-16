class FollowingUser < ActiveRecord::Base
  belongs_to :user
  FollowingUser.create(:user_id                    =>user.id,
                       :following_user_id          =>following_user.id,
                       :following_user_name        =>following_user.name,
                       :following_user_aboutme     =>following_user.aboutme,
                       :following_user_image_path  =>following_user.image_path)
end
