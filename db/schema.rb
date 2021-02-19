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

ActiveRecord::Schema.define(version: 2021_02_19_004113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "trades", force: :cascade do |t|
    t.bigint "user_id"
    t.string "symbol"
    t.integer "quantity"
    t.decimal "price"
    t.decimal "total"
    t.string "order_type"
    t.date "order_date"
    t.string "reference_id"
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
    t.string "uid"
    t.string "email"
    t.string "displayName"
  end

  create_table "watchlists", force: :cascade do |t|
    t.string "symbol"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

end
