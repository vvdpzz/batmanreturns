class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.references :user
      t.integer :user
      t.string :user_name
      t.integer :question_id
      t.string :question_title
      t.integer :answer_id
      t.string :answer_content
      t.integer :question_id
      t.string :question_content
      t.text :content
      t.boolean :read, :default => false
      # t.references :notification_type

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
