class VotesController < ApplicationController
  def up
    # 从 settings.yml 中 读 出 配 置 信 息
    credit_per_vote = APP_CONFIG["#{@instance.class.name.downcase}_vote_up"]
    max_credit_per_day = APP_CONFIG["max_credit_per_day"]
    vote_limit = APP_CONFIG["vote_limit"]
    instance_user = @instance.user
    
    # 判 断 当 前 用 户 是 否 拥 可 以 投 票
    if current_user.credit > vote_limit and current_user.vote_per_day > 0 and instance_user.credit_today < 200
      # 修 改 投 票 数
      @instance.votes_count += 1
      current_user.vote_per_day -= 1
      
      instance_user.credit_today += credit_per_vote
      # 当 获 得 加 分 的 用 户 的credit 达 到 上 限 时
      if instance_user.credit_today >= max_credit_per_day
        instance_user.credit += credit_per_vote - (instance_user.credit_today - max_credit_per_day)
        instance_user.credit_today = max_credit_per_day
      else
        instance_user.credit += credit_per_vote
      end
      
      # 保 存 相 关 信 息 的 变 更
      current_user.save
      instance_user.save
      @instance.save
    end
  end
  
  def down
    # 从 settings.yml 中 读 出 配 置 信 息
    credit_per_vote = APP_CONFIG["#{@instance.class.name.downcase}_vote_down"]
    cost_per_vote = APP_CONFIG["answer_vote_down_to_voter"]
    vote_limit = APP_CONFIG["vote_limit"]
    instance_user = @instance.user
    
    # 判 断 当 前 用 户 是 否 拥 可 以 投 票
    if current_user.credit > vote_limit and current_user.vote_per_day > 0
      @instance.votes_count -= 1
      current_user.vote_per_day -= 1
      
      # 当 前 用 户 因 举 报 而 付 出 代 价
      current_user.credit_today -= cost_per_vote
      current_user.credit -= cost_per_vote
      
      instance_user.credit -= credit_per_vote
      instance_user.credit_today -= credit_per_vote
      
      # 保 存 相 关 信 息 的 变 更
      current_user.save
      instance_user.save
      @instance.save
    end    
  end
  
  protected
  def who_called_comment
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return @instance = $1.classify.constantize.find(value)
      end
    end
  end
end
