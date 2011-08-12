class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :user
      t.string :title
      t.text :content
      t.integer :credit
      t.decimal :money, :precision => 8, :scale => 2
      t.datetime :expire_time
      t.integer :answers_count
      t.integer :comments_count

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
