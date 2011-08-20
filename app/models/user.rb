class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me,
  :username, :realname, :credit, :money, :vote_per_day, :credit_today
  
  include SentientUser
  
  include Gravtastic
  gravtastic
  
  has_many :questions
  has_many :answers
  has_many :pay, :class_name => "transaction", :foreign_key => "pay_u_id"
  has_many :recieve, :class_name => "transaction", :foreign_key => "receive_u_id"
  has_many :votes
  has_many :following_user
  has_many :notifications
  has_many :relationships
  
  def has_relationship(user_id)
    $redis.sismember("user:#{user_id}.follows", self.id)
  end
end
