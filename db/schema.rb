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

ActiveRecord::Schema.define(version: 2021_02_28_004136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balance_histories", force: :cascade do |t|
    t.decimal "value"
    t.decimal "change"
    t.decimal "change_pct"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "positions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "symbol"
    t.decimal "price"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "trade_reference_id", null: false
    t.index ["user_id"], name: "index_positions_on_user_id"
  end

  create_table "shares", force: :cascade do |t|
    t.bigint "user_id"
    t.string "symbol"
    t.decimal "price"
    t.string "trade_reference_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "size"
    t.float "purchase_value"
    t.index ["user_id"], name: "index_shares_on_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.bigint "user_id"
    t.string "symbol"
    t.integer "quantity"
    t.decimal "price"
    t.decimal "total"
    t.string "order_type"
    t.string "reference_id"
    t.datetime "created_at", null: false
    t.index ["user_id"], name: "index_trades_on_user_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "cash"
    t.string "apns_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_infos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.string "email", null: false
    t.string "displayName"
    t.decimal "cash"
    t.decimal "apns_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "watchlists", force: :cascade do |t|
    t.string "symbol"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

end
