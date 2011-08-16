class CreateFollowingUsers < ActiveRecord::Migration
  def self.up
    create_table :following_users do |t|
      t.references :user
      t.integer :following_user_id
      t.string  :following_user_name
      t.string  :following_user_aboutme
      t.string  :following_user_image_path, :default => '/tmp/images/'
      t.boolean :following, :default => true
      
      t.timestamps
    end

  end

  def self.down
    drop_table :following_users
  end
end
