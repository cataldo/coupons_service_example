# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130711205626) do

  create_table "codepacks", :force => true do |t|
    t.integer  "deal_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "codes", :force => true do |t|
    t.integer  "codepack_id"
    t.string   "code"
    t.integer  "coupon_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "coupons", :force => true do |t|
    t.integer  "deal_id"
    t.integer  "user_id"
    t.string   "state"
    t.datetime "use_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "deals", :force => true do |t|
    t.string   "name"
    t.text     "descr"
    t.integer  "max_coupons"
    t.integer  "min_coupons"
    t.datetime "publication_time"
    t.datetime "deadline"
    t.string   "type"
    t.integer  "coupons_count"
    t.integer  "price"
    t.integer  "discount"
    t.integer  "full_cost"
    t.string   "state"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "deal_id"
    t.integer  "coupon_id"
    t.integer  "sum"
    t.string   "state"
    t.datetime "paid_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "balance"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
