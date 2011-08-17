class FavoriteController < ApplicationController
  before_filter :load_favorite
  
  def favorite
    @favorite = current_user.favorite_questionas.build(params[:favorite_question])
    if @favorite.save
      redirect_to(@favorite, :notice => 'Your favorite question has been added successfully!')
     # 这 里 没 有 else 交 给 js 可 以 没 有 提 示 只 是 星 星 变 亮
    end
  end
  
  def undo
    @favorite = current_user.favorite_questionas.build(params[:favorite_question])
    @favorite.update_attributes(:favorite=>false)
    if @favorite.save
      redirect_to(@favorite, :notice => 'Question has been removed from your favorite!')
    end
  end

  protected
    def load_favorite
      @favorite = current_user.favorite_questions.find(params[:id])
    end
end