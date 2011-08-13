class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :user
      t.string :title
      t.text :content
      t.integer :credit, :default => 0
      t.decimal :money, :precision => 8, :scale => 2, :default => 0
      t.datetime :expire_time
      t.integer :votes_count, :default => 0
      t.integer :answers_count, :default => 0
      
      t.binary :comments, :limit => 10.megabyte

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
