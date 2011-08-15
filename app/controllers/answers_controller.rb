class AnswersController < ApplicationController
  before_filter :find_question
  def create
    answer = current_user.answers.build params[:answer]
    answer.question_id = @question.id
    @question.answers_count += 1
    answer.save
    @question.save
  end
  
  def accept
    if @question.accept_a_id == 0
      answer = @question.answers.find params[:answer_id]
      user = answer.user
      @question.accept_a_id = params[:answer_id]
      answer.is_correct = true
      if @question.credit != 0 || @question.money != 0
        answer.user.credit += @question.credit
      end
      @question.save
      answer.save
      user.save
    end
  end

  protected
    def find_question
      @question = Question.find params[:question_id]
    end
end
