class CreateTransactionMoneys < ActiveRecord::Migration
  def self.up
    create_table :transaction_moneys do |t|
      t.references :question
      t.references :answer
      t.integer :pay_u_id,           :null => false
      t.string :pay_u_name,          :null => false
      t.integer :receive_u_id, :default => 0
      t.string :receive_u_name,:default => ''
      t.decimal :amount, :precision => 8, :scale => 2, :null => false
      t.integer :operation_id,       :null => false 
      # 1 充 值
      # 2 提 现 
      # 3 被 选 为 正 确 答 案 增 加
      # 4 选 择 别 人 的 答 案 为 正 确 答 案 而 付 费
      t.string  :operation,    :null => false, :default => '问 题 奖 励 现 金' 
      t.string :status    ,    :null => false, :default => ''
      t.text :remark      ,    :null => false, :default => ""  # <br>YYYYMMDD HH:MIN:SS 谁 做 了 什 么 操 作</br> 
      # 以 下 为 银 行 信 息 
      t.integer :bank_id        ,:default => 0
      t.string :bank_name       ,:default => ''
      t.string :bank_city       ,:default => ''
      t.string :bank_area       ,:default => ''
      t.string :bank_branch     ,:default => ''
      t.integer :bank_account_no,:default => 0
      t.integer :ali_account_no ,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end