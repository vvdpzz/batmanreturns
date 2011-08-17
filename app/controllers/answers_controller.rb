class AnswersController < ApplicationController
  before_filter :find_question
  def create
    answer = current_user.answers.build params[:answer]
    answer.question_id = params[:question_id]
    
    if @question.not_free?
      if answer.save
        current_user.credit -= APP_CONFIG["answer_paid_question"]
      end
    else
      answer.save
    end
    # 把 参 数 的 获 取 放 到 Resque 里 获 取 了（ 这 里 最 后 一 个 参 数 可 以 考 虑 在 answer 中 添 加 一 个 字 段 ），这 里 就 没 那 么 丑 了
    Resque.enqueue(NewAnswerCall, @question, answer, current_user.realname)
    
    @question.answers_count += 1
    @question.save
    current_user.save
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
    end
  end

  protected
    def find_question
      @question = Question.find params[:question_id]
    end
end
