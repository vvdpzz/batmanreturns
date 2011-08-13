class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :credit, :money
  
  include SentientUser
  
  has_many :questions
  has_many :answers
  has_many :pay, :class_name => "transaction", :foreign_key => "pay_u_id"
  has_many :recieve, :class_name => "transaction", :foreign_key => "receive_u_id"
end
