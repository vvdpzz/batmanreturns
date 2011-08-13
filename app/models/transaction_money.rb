class TransactionMoney < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  belongs_to :answer

  def self.tran_money(question)
    TransactionMoney.create(:question_id    =>question.id,
                            :answer_id      =>0,
                            :pay_u_id       =>question.user.id,
                            :pay_u_name     =>question.user.username,
                            :amount         =>question.money,
                            :operation_id   =>7,
                            :operation      =>'Question Reward')
    
  end
end
