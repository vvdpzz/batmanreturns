class QuestionsController < ApplicationController

  before_filter :load_question, :only => [:edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.build(params[:question])

    if @question.save
      redirect_to(@question, :notice => 'Question was successfully created.')
    else
      render :new
    end

  end

  def update
    if @question.update_attributes(params[:question])
      redirect_to(@question, :notice => 'Question was successfully updated.')
    else
      render :edit
    end

  end

  def destroy
    @question.destroy
    redirect_to(questions_url)
  end

  protected
    def load_question
      @question = current_user.questions.find(params[:id])
    end
end
