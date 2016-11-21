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

ActiveRecord::Schema.define(version: 20161120214052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "homes", force: :cascade do |t|
    t.string   "condo_name"
    t.string   "va_condo_id",             null: false
    t.string   "detail_uri"
    t.string   "address"
    t.string   "status"
    t.date     "last_update"
    t.date     "request_received_date"
    t.date     "request_completion_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["detail_uri"], name: "index_homes_on_detail_uri", unique: true, using: :btree
    t.index ["va_condo_id"], name: "index_homes_on_va_condo_id", unique: true, using: :btree
  end

  create_table "lob_addresses", force: :cascade do |t|
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "address_country"
    t.string   "object"
    t.string   "message"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "home_id",         null: false
    t.index ["home_id"], name: "index_lob_addresses_on_home_id", using: :btree
  end

end
