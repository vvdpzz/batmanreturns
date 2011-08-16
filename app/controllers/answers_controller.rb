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
