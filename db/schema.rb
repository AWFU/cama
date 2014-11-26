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

ActiveRecord::Schema.define(version: 20141126073540) do

  create_table "addressbooks", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addressbooks", ["user_id"], name: "index_addressbooks_on_user_id"

  create_table "admins", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true

  create_table "admins_roles", id: false, force: true do |t|
    t.integer "admin_id"
    t.integer "role_id"
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id"

  create_table "announcements", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.integer  "ranking",      default: 999, null: false
    t.string   "status"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.text     "js_context"
    t.text     "html_context"
    t.string   "slug"
  end

  add_index "announcements", ["article_id"], name: "index_announcements_on_article_id"
  add_index "announcements", ["id", "type"], name: "index_announcements_on_id_and_type"

  create_table "articles", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "related_product_id"
    t.integer  "ranking",            default: 999, null: false
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "banners", ["id", "type"], name: "index_banners_on_id_and_type"

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id"

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customizedpages", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.integer  "ranking",      default: 999, null: false
    t.string   "status"
    t.text     "html_content"
    t.text     "js_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliveries", force: true do |t|
    t.string   "name"
    t.string   "tracking_url"
    t.integer  "normal_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shipping_condition"
    t.string   "iscod"
    t.integer  "discount_criteria",  default: 1500
    t.integer  "discount_fee",       default: 0
  end

  create_table "districts", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["city_id"], name: "index_districts_on_city_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "galleries", force: true do |t|
    t.string   "file_name"
    t.string   "content_type"
    t.string   "file_size"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "ranking",         default: 999, null: false
  end

  add_index "galleries", ["attachable_id", "attachable_type"], name: "index_galleries_on_attachable_id_and_attachable_type"
  add_index "galleries", ["id", "type"], name: "index_galleries_on_id_and_type"

  create_table "jobs", force: true do |t|
    t.string   "name"
    t.string   "websiteurl"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orderasks", force: true do |t|
    t.integer  "order_id"
    t.text     "description"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orderasks", ["order_id"], name: "index_orderasks_on_order_id"

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

  add_index "orderitems", ["order_id"], name: "index_orderitems_on_order_id"

  create_table "orderlogs", force: true do |t|
    t.integer  "order_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "inner_state"
  end

  add_index "orderlogs", ["order_id"], name: "index_orderlogs_on_order_id"

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
    t.string   "invoice_type"
    t.string   "invoice_companynum"
    t.string   "invoice_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aasm_state",          default: "hold"
    t.string   "delivery_type"
    t.string   "package_tracking_no"
    t.text     "order_memo"
    t.text     "human_involved_memo"
    t.string   "accountinfo"
    t.integer  "shipping_fee"
    t.string   "ship_to"
    t.string   "shipped",             default: "no"
    t.string   "paid",                default: "no"
  end

  add_index "orders", ["aasm_state"], name: "index_orders_on_aasm_state"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "photos", force: true do |t|
    t.string   "image"
    t.string   "name"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["article_id"], name: "index_photos_on_article_id"

  create_table "product_cates", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "depth"
  end

  add_index "product_cates", ["parent_id"], name: "index_product_cates_on_parent_id"

  create_table "product_stocks", force: true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.integer  "amount"
    t.boolean  "assign_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_stocks", ["product_id"], name: "index_product_stocks_on_product_id"

  create_table "products", force: true do |t|
    t.integer  "product_cate_id"
    t.string   "name"
    t.integer  "price"
    t.integer  "price_for_sale"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
    t.text     "intro"
    t.text     "keypoints"
    t.text     "taste_attributes"
    t.integer  "grindable"
    t.string   "unit"
    t.text     "grind_level"
  end

  add_index "products", ["article_id"], name: "index_products_on_article_id"
  add_index "products", ["product_cate_id"], name: "index_products_on_product_cate_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "services", force: true do |t|
    t.string   "name"
    t.integer  "reference_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_service_ships", force: true do |t|
    t.integer  "service_id"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_service_ships", ["service_id"], name: "index_store_service_ships_on_service_id"
  add_index "store_service_ships", ["store_id"], name: "index_store_service_ships_on_store_id"

  create_table "stores", force: true do |t|
    t.string   "name"
    t.text     "intro"
    t.string   "phone"
    t.string   "address"
    t.string   "country"
    t.string   "city"
    t.string   "district"
    t.text     "ophour"
    t.text     "latlng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "talks", force: true do |t|
    t.string   "title"
    t.integer  "ranking",    default: 999, null: false
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subtitle"
    t.string   "slug"
  end

  add_index "talks", ["article_id"], name: "index_talks_on_article_id"

  create_table "user_roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["name", "resource_type", "resource_id"], name: "index_user_roles_on_name_and_resource_type_and_resource_id"
  add_index "user_roles", ["name"], name: "index_user_roles_on_name"

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
    t.string   "address_to_receive"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_user_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "user_role_id"
  end

  add_index "users_user_roles", ["user_id", "user_role_id"], name: "index_users_user_roles_on_user_id_and_user_role_id"

end
