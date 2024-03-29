# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_12_170356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balance_histories", force: :cascade do |t|
    t.decimal "value", precision: 10, scale: 2
    t.decimal "change", precision: 10, scale: 2
    t.decimal "change_pct", precision: 10, scale: 2
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_balance_histories_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "sku"
    t.decimal "price"
    t.bigint "user_id", null: false
    t.string "purchase_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "shares", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "symbol"
    t.decimal "price", precision: 10, scale: 2
    t.integer "size"
    t.string "trade_reference_id"
    t.decimal "purchase_value", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trade_reference_id"], name: "shares_trade_reference_id_key", unique: true
    t.index ["user_id"], name: "index_shares_on_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "symbol"
    t.integer "size"
    t.decimal "price", precision: 10, scale: 2
    t.decimal "total", precision: 10, scale: 2
    t.string "order_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reference_id"
    t.index ["reference_id"], name: "trades_reference_id_key", unique: true
    t.index ["user_id"], name: "index_trades_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.string "email", null: false
    t.string "displayName"
    t.decimal "cash"
    t.decimal "apns_token"
    t.decimal "portfolio_value", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "users_email_key", unique: true
    t.index ["uid"], name: "users_uid_key", unique: true
  end

  create_table "watchlists", force: :cascade do |t|
    t.string "symbol"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

  add_foreign_key "balance_histories", "users"
  add_foreign_key "purchases", "users"
  add_foreign_key "shares", "users"
  add_foreign_key "trades", "users"
  add_foreign_key "watchlists", "users"
end
