class CreateFavoriteQuestions < ActiveRecord::Migration
  def self.up
    create_table :favorite_questions do |t|
      t.references :user
      t.references :question
      t.boolean :favorite, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :favorite_questions
  end
end
