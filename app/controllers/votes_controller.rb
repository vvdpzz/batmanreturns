class VotesController < ApplicationController
  before_filter :who_called_vote
  def up
    # 从 settings.yml 中 读 出 配 置 信 息
    credit_per_vote = APP_CONFIG["#{@instance.class.name.downcase}_vote_up"]
    max_credit_per_day = APP_CONFIG["max_credit_per_day"]
    vote_limit = APP_CONFIG["vote_limit"]
    instance_user = @instance.user
    
    # 从redis 中 读 出 是 否 投 过 此 问 题 或 答 案
    have_not_vote_up = !$redis.sismember("#{@instance_type[0].chr}:#{@instance.id}.up_voter", current_user.id)
    have_vote_down = $redis.sismember("#{@instance_type[0].chr}:#{@instance.id}.down_voter", current_user.id)

    # 判 断 当 前 用 户 是 否 拥 可 以 投 票
    if current_user.credit > vote_limit and current_user.vote_per_day > 0 and instance_user.credit_today < max_credit_per_day and have_not_vote_up
      # 修 改 投 票 数
      if have_vote_down                                   # 已 投 过 负 票 ，现 在 改 投 正 票
        @instance.votes_count += 2
      else
        @instance.votes_count += 1
      end
      current_user.vote_per_day -= 1
      
      instance_user.credit_today += credit_per_vote
      # 当 获 得 加 分 的 用 户 的credit 达 到 上 限 时
      if instance_user.credit_today >= max_credit_per_day
        instance_user.credit += credit_per_vote - (instance_user.credit_today - max_credit_per_day)
        instance_user.credit_today = max_credit_per_day
      else
        instance_user.credit += credit_per_vote
      end
      
      # 将 投 票 信 息 保 存
      if @instance_type == "question"
        vote = current_user.votes.build(:question_id => @instance.id, :vote => 1)
      else
        vote = current_user.votes.build(:answer_id => @instance.id, :vote => 1)
      end
      # 将 问 题 或 答 案 的 投 票 者 记 录 到redis
      $redis.sadd("#{@instance_type[0].chr}:#{@instance.id}.up_voter", current_user.id)
      $redis.srem("#{@instance_type[0].chr}:#{@instance.id}.down_voter", current_user.id)
      
      # 保 存 相 关 信 息 的 变 更
      current_user.save
      instance_user.save
      @instance.save
      vote.save
    end
  end
  
  def down
    # 从 settings.yml 中 读 出 配 置 信 息
    credit_per_vote = APP_CONFIG["#{@instance.class.name.downcase}_vote_down"]
    cost_per_vote = APP_CONFIG["answer_vote_down_to_voter"]
    vote_limit = APP_CONFIG["vote_limit"]
    instance_user = @instance.user
    
    # 从redis 中 读 出 是 否 已 经 给 此 问 题 或 答 案 投 过 负 票
    have_not_vote_down = !$redis.sismember("#{@instance_type[0].chr}:#{@instance.id}.down_voter", current_user.id)
    have_vote_up = $redis.sismember("#{@instance_type[0].chr}:#{@instance.id}.up_voter", current_user.id)
    
    # 判 断 当 前 用 户 是 否 拥 可 以 投 票
    if current_user.credit > vote_limit and current_user.vote_per_day > 0 and have_not_vote_down
      if have_vote_up                               # 已 投 过 正 票 ，现 在 改 投 负 票
        @instance.votes_count -= 2
      else
        @instance.votes_count -= 1
      end
      current_user.vote_per_day -= 1
      
      # 当 前 用 户 因 举 报 而 付 出 代 价
      current_user.credit_today -= cost_per_vote
      current_user.credit -= cost_per_vote
      
      instance_user.credit -= credit_per_vote
      instance_user.credit_today -= credit_per_vote
      
      # 将 投 票 信 息 保 存 到 数 据 库 中
      if @instance_type == "question"
        vote = current_user.votes.build(:question_id => @instance.id, :vote => -1)
      else
        vote = current_user.votes.build(:answer_id => @instance.id, :vote => -1)
      end
      # 将 问 题 或 答 案 的 投 票 者 记 录 到redis
      $redis.sadd("#{@instance_type[0].chr}:#{@instance.id}.down_voter", current_user.id)
      $redis.srem("#{@instance_type[0].chr}:#{@instance.id}.up_voter", current_user.id)
      # 保 存 相 关 信 息 的 变 更
      current_user.save
      instance_user.save
      @instance.save
      vote.save
    end    
  end
  
  protected
  def who_called_vote
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @instance = $1.classify.constantize.find(value)
        @instance_type = $1
      end
    end
  end
end
