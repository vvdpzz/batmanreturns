class QuestionsController < ApplicationController

  before_filter :load_question, :only => [:edit, :update]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
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
      if @question.credit > 0 
        credit_was = @question.user.credit
        credit_now = @question.user.credit - @question.credit
        @question.user.update_attributes(:credit=>credit_now)
        TransactionCredit.tran_credit(@question)
      end
      if @question.money > 0 
        money_was = @question.user.money
        money_now = @question.user.money - @question.money
        @question.user.update_attributes(:money=>money_now)
        TransactionMoney.tran_money(@question)
      end
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
    @question = Question.find(params[:id])
    @question.destroy
  end
  
  def follow
    question = Question.find params[:id]
    if question
      records = FollowedQuestion.where(:user_id => current_user.id, :question_id => question.id)
      if records.empty?
        current_user.followed_questions.create(:question_id => question.id)
      else
        record = records.first
        record.update_attribute(:followed, !record.followed)
      end
    end
  end
  
  def favorite
    question = Question.find params[:id]
    if question
      records = FavoriteQuestion.where(:user_id => current_user.id, :question_id => question.id)
      if records.empty?
        current_user.favorite_questions.create(:question_id => question.id)
      else
        record = records.first
        record.update_attribute(:favorite, !record.favorite)
      end
    end
  end

  protected
    def load_question
      @question = current_user.questions.find(params[:id])
    end
end
