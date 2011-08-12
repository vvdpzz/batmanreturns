class VotesController < ApplicationController
  def up
    if current_user.credit > 15 and current_user.vote_per_day > 0
      @instance.vote
      current_user.credit_today
    end
  end
  
  def down
    
  end
end
