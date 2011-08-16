class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :username
      t.string :realname
      t.string :aboutme
      t.string :image_path, :default => '/tmp/images/default/'
      
      t.integer :credit, :default => 0
      t.decimal :money, :precision => 8, :scale => 2, :default => 0
            
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      
      t.integer :vote_per_day, :default => 40
      t.integer :credit_today, :default => 0

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
