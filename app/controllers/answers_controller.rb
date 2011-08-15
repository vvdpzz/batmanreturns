class AnswersController < ApplicationController
  before_filter :find_question
  def create
    answer = current_user.answers.build params[:answer]
    answer.question_id = @question.id
    answer.save
  end
  
  def accept
    if @question.accept_a_id == 0
      answer = @question.answers.find params[:answer_id]
      @question.accept_a_id = params[:answer_id]
      answer.is_correct = true
      @question.save
      answer.save
    end
  end

  protected
    def find_question
      @question = Question.find params[:question_id]
    end
end
