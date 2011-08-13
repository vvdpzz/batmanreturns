class CreateTransactionCredits < ActiveRecord::Migration
  def self.up
    create_table :transaction_credits do |t|
      t.references :question
      t.references :answer
      t.integer :pay_u_id,     :null => false
      t.string :pay_u_name,    :null => false
      t.integer :receive_u_id, :default => 0
      t.string :receive_u_name,:default => ''
      t.integer :credits,      :null => false, :default => 10
      t.integer :operation_id, :null => false, :default => 7
      # 5 被 选 为 正 确 答 案
      #6 选 择 别 人 的 答 案 为 正 确 答 案 而 付 积 分
      #7 问 题 奖 励 积 分
      t.string  :operation,    :null => false, :default => '问 题 奖 励 积 分' 
      t.string :status    ,    :null => false, :default => ''
      t.text :remark      ,    :null => false, :default => ""   # <br>YYYYMMDD HH:MIN:SS 谁 做 了 什 么 操 作</br>

      t.timestamps
    end
  end

  def self.down
    drop_table :transaction_credits
  end
end
