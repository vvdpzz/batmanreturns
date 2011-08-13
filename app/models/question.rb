class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  
  validates_numericality_of :money, :message => "is not a number"
  validates_numericality_of :credit, :message => "is not a number"
  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :content, :message => "can't be blank"
  
  validate :enough_money_to_reward, :on => :create
  validate :enough_credit_to_reward, :on => :create
  
  def enough_money_to_reward
    if self.user.money < self.money
      errors.add_to_base("You do NOT have enough money to pay the reward! Please recharge!")
    end
  end
  
  def enough_credit_to_reward
    if self.user.credit < self.credit
      errors.add_to_base("You do NOT have enough credit to pay the reward! Please answer more questions for more credit")
    end
  end
  
  
  
  def charge
    amount = APP_CONFIG['answer_charge'].to_i
    give_money_to_system_user(amount)
  end
  
  def give_money_to_system_user(amount)
    system = User.find_by_id i
    system.update_attribute(:money, system.money + amount)
  end
  
  
  

end
