class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, :counter_cache => true
  has_many :votes
  
  validate :enough_credit_to_answer, :on => :create
  
  def enough_credit_to_answer
    if self.user.credit < APP_CONFIG["answer_paid_question"]
      errors.add_to_base("You do NOT have enough credit to answer this paid question! Please earn more credits!")
    end
  end
  
end
