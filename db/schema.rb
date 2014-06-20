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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140620070400) do

  create_table "orderitems", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_stock_id"
    t.string   "item_name"
    t.string   "item_stockname"
    t.integer  "item_price"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.string   "ordernum"
    t.string   "buyer_name"
    t.string   "buyer_tel"
    t.string   "receiver_name"
    t.string   "receiver_tel"
    t.string   "receiver_address"
    t.string   "payment_type"
    t.string   "payment_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_cates", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_stocks", force: true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "assign_amount"
  end

  create_table "products", force: true do |t|
    t.integer  "product_cate_id"
    t.string   "name"
    t.integer  "price"
    t.integer  "price_for_sale"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "address"
    t.string   "tel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
