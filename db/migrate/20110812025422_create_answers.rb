class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :user
      t.references :question
      t.text :content
      t.string :about_me
      t.boolean :is_correct

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
