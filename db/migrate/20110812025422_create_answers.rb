class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :user
      t.references :question
      t.text :content
      t.string :aboutme
      t.integer :votes_count, :default => 0
      t.boolean :is_correct, :default => false
      
      t.binary :comments, :limit => 10.megabyte

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
