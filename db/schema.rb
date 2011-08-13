# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110812081910) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "content"
    t.string   "about_me"
    t.boolean  "is_correct",                      :default => false
    t.binary   "comments",    :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.integer  "credit",                                                          :default => 0
    t.decimal  "money",                             :precision => 8, :scale => 2, :default => 0.0
    t.datetime "expire_time"
    t.integer  "answers_count",                                                   :default => 0
    t.binary   "comments",      :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transaction_credits", :force => true do |t|
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "pay_u_id",                                                       :null => false
    t.string   "pay_u_name",                                                     :null => false
    t.integer  "receive_u_id",   :default => 0
    t.string   "receive_u_name", :default => ""
    t.integer  "credits",        :default => 10,                                 :null => false
    t.integer  "operation_id",   :default => 7,                                  :null => false
    t.string   "operation",      :default => "问 题 奖 励 积 \345\210\206", :null => false
    t.string   "status",         :default => "",                                 :null => false
    t.text     "remark",                                                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transaction_moneys", :force => true do |t|
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "pay_u_id",                                                                                      :null => false
    t.string   "pay_u_name",                                                                                    :null => false
    t.integer  "receive_u_id",                                  :default => 0
    t.string   "receive_u_name",                                :default => ""
    t.decimal  "amount",          :precision => 8, :scale => 2,                                                 :null => false
    t.integer  "operation_id",                                                                                  :null => false
    t.string   "operation",                                     :default => "问 题 奖 励 现 \351\207\221", :null => false
    t.string   "status",                                        :default => "",                                 :null => false
    t.text     "remark",                                                                                        :null => false
    t.integer  "bank_id",                                       :default => 0
    t.string   "bank_name",                                     :default => ""
    t.string   "bank_city",                                     :default => ""
    t.string   "bank_area",                                     :default => ""
    t.string   "bank_branch",                                   :default => ""
    t.integer  "bank_account_no",                               :default => 0
    t.integer  "ali_account_no",                                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                               :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128,                               :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "vote_per_day",                                                        :default => 40
    t.integer  "credit_today",                                                        :default => 0
    t.string   "username",                                                            :default => "xxd", :null => false
    t.integer  "credit",                                                              :default => 0
    t.decimal  "money",                                 :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "vote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
