class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.references :user
      t.integer :user
      t.string :user_name
      t.integer :question_id
      t.string :question_title
      t.string :question_content
      t.integer :answer_id
      t.string :answer_content
      t.integer :comment_id
      t.string :comment_content
      t.integer :reply_id
      t.string :reply_content
      t.boolean :read, :default => false
      t.integer :notification_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
