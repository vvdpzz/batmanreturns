class FollowedQuestionController < ApplicationController
  before_filter :load_followed

  def followed
    @followed_question = current_user.followed_questions.build(params[:followed_question])
    if @followed_question.save
      redirect_to(@followed_question, :notice => 'Your favorite question has been added successfully!')
     # 这 里 没 有 else 交 给 js 可 以 没 有 提 示 只 是 星 星 变 亮
    end
  end

  def undo
    @followed_question = current_user.followed_questions.build(params[:followed_question])
    @followed_question.update_attributes(:followed=>false)
    if @followed_question.save
      redirect_to(@followed_question, :notice => 'Question has been removed from your favorite!')
    end
  end

  protected
    def load_followed
      @followed_question = current_user.followed_questions.find(params[:id])
    end
end
