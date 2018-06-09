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

ActiveRecord::Schema.define(version: 2018_08_15_160914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bet_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "bets", force: :cascade do |t|
    t.text "comment"
    t.float "coefficient", null: false
    t.decimal "profit"
    t.string "outcome", null: false
    t.integer "wager", null: false
    t.string "choice1"
    t.string "choice2"
    t.bigint "bookmaker_id"
    t.bigint "discipline_id"
    t.bigint "event_id"
    t.bigint "result_variant_id"
    t.bigint "bet_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bet_type_id"], name: "index_bets_on_bet_type_id"
    t.index ["bookmaker_id"], name: "index_bets_on_bookmaker_id"
    t.index ["discipline_id"], name: "index_bets_on_discipline_id"
    t.index ["event_id"], name: "index_bets_on_event_id"
    t.index ["result_variant_id"], name: "index_bets_on_result_variant_id"
  end

  create_table "bookmaker_balances", force: :cascade do |t|
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "RUB", null: false
    t.bigint "user_id"
    t.bigint "bookmaker_id"
    t.index ["bookmaker_id"], name: "index_bookmaker_balances_on_bookmaker_id"
    t.index ["user_id"], name: "index_bookmaker_balances_on_user_id"
  end

  create_table "bookmakers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplines_participants", id: false, force: :cascade do |t|
    t.bigint "discipline_id", null: false
    t.bigint "participant_id", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.date "period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "result_variants", force: :cascade do |t|
    t.string "name"
  end

end
