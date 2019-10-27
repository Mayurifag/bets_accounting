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

ActiveRecord::Schema.define(version: 2019_08_11_211029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "bet_types", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name", null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_bet_types_on_name", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "bets", force: :cascade do |t|
    t.bigint "bet_type_id"
    t.bigint "bookmaker_id"
    t.bigint "choice1_id"
    t.bigint "choice2_id"
    t.float "coefficient", null: false
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.bigint "discipline_id"
    t.bigint "event_id"
    t.string "outcome", null: false
    t.decimal "profit"
    t.bigint "result_variant_id"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "wager", null: false
    t.index ["bet_type_id"], name: "index_bets_on_bet_type_id"
    t.index ["bookmaker_id"], name: "index_bets_on_bookmaker_id"
    t.index ["choice1_id"], name: "index_bets_on_choice1_id"
    t.index ["choice2_id"], name: "index_bets_on_choice2_id"
    t.index ["created_at"], name: "index_bets_on_created_at"
    t.index ["discipline_id"], name: "index_bets_on_discipline_id"
    t.index ["event_id"], name: "index_bets_on_event_id"
    t.index ["result_variant_id"], name: "index_bets_on_result_variant_id"
  end

  create_table "bookmakers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name", null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_bookmakers_on_name", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "disciplines", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name", null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_disciplines_on_name", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name", null: false
    t.date "period"
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_events_on_name", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "participants", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name", null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_participants_on_name", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "result_variants", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name", null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_result_variants_on_name", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bets", "participants", column: "choice1_id"
  add_foreign_key "bets", "participants", column: "choice2_id"
end
