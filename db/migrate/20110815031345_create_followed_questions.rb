class CreateFollowedQuestions < ActiveRecord::Migration
  def self.up
    create_table :followed_questions do |t|
      t.references :user
      t.references :question
      t.boolean :followed, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :followed_questions
  end
end
