class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.string :sender_name
      t.string :description
                                    # 1        问 题 有 了 新 答 案
                                    # 2        问 题 有 了 新 评 论
                                    # 3        答 案 有 了 新 评 论
                                    # 4        答 案 被 接 受
                                    # 5        用 户 被 关 注
                                    
      t.integer :subject_id
      t.string :subject_content
      t.integer :object_id
      t.string :object_content
      t.boolean :read, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
