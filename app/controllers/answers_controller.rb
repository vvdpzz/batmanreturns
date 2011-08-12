class AnswersController < ApplicationController
  def create
    question = Question.find params[:question_id]
    answer = current_user.answers.build params[:answer]
    
    answer.save
  end

end
