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

ActiveRecord::Schema.define(version: 20160825201455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deals", force: :cascade do |t|
    t.date     "begin_res"
    t.date     "end_res"
    t.boolean  "complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "piece_id"
    t.index ["piece_id"], name: "index_deals_on_piece_id", using: :btree
    t.index ["user_id"], name: "index_deals_on_user_id", using: :btree
  end

  create_table "periods", force: :cascade do |t|
    t.datetime "begin_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "piece_id"
    t.index ["piece_id"], name: "index_periods_on_piece_id", using: :btree
  end

  create_table "pieces", force: :cascade do |t|
    t.string   "name"
    t.string   "brand"
    t.text     "description"
    t.string   "image"
    t.string   "image_b"
    t.string   "size"
    t.string   "colour"
    t.string   "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "begin_date"
    t.date     "end_date"
    t.integer  "price_cat"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_pieces_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.string   "surname"
    t.date     "date_of_birth"
    t.string   "addr_street"
    t.string   "addr_number"
    t.string   "postcode"
    t.string   "addr_town"
    t.string   "fav_color"
    t.string   "phone"
    t.string   "gender"
    t.string   "size"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  add_foreign_key "deals", "pieces"
  add_foreign_key "deals", "users"
  add_foreign_key "periods", "pieces"
  add_foreign_key "pieces", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "roles"
end
