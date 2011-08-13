class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      
      t.integer :vote_per_day, :default => 40
      t.integer :credit_today, :default => 0
      t.string  :username    , :null => false, :default => 'xxd' 
      #t.string :first_name,       :null => false , :default => 'xxd'
      #t.string :last_name,        :null => false , :default => 'xxd'
      #t.string :image_url,        :default => '/tmp/images/' #
      #t.string :about_me
      #t.integer :subscribe_count
      #t.integer :following_count
      #t.integer :follower_count
      #t.integer :publish_q_count
      #t.integer :publish_a_count
      t.integer :credit, :default => 0
      t.decimal :money, :precision => 8, :scale => 2, :default => 0
      #t.integer :vote_per_day, :default => 40
      #t.integer :credit_today, :default => 0
      
      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


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
