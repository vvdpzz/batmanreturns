class AnswersController < ApplicationController
  before_filter :load_question
  def create
    @answer = current_user.answers.build params[:answer]
    @answer.question_id = params[:question_id]
    credit_answer_paid_question = APP_CONFIG["answer_paid_question"]
    if @question.not_free?
      # 回 答 付 费 问 题 ，扣 除 用 户 积 分
      if current_user.credit >= credit_answer_paid_question
        current_user.credit -= credit_answer_paid_question
        @answer.save
        current_user.save
        @question.answers_count += 1
      end
    else
      @answer.save                     # 回 答 免 费 问 题 ，直 接 保 存
      @question.answers_count += 1
    end
    @question.save

    Resque.enqueue(NewAnswerCall, @question, @answer, current_user.realname)
  end
  
  def accept
    if @question.accept_a_id == 0
      answer = @question.answers.find params[:answer_id]
      user = answer.user
      @question.accept_a_id = params[:answer_id]
      answer.is_correct = true
      if @question.credit != 0 || @question.money != 0
        user.credit += @question.credit
        user.money += @question.money
      end
      user.credit += APP_CONFIG["answer_is_accepted"]
      @question.user.credit += APP_CONFIG["answer_is_accepted_to_acceptor"]

      @question.save
      @question.user.save
      answer.save
      user.save
      if answer.save
        Resque.enqueue(NewAcceptQueue, @question, current_user.id,current_user.realname)
      end
    end
  end

  protected
    def load_question
      @question = Question.find params[:question_id]
    end
end
