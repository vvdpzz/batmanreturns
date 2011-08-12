class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.references :user
      t.references :question
      t.references :answer
      t.integer :vote

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
