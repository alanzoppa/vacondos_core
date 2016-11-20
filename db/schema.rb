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

  create_table "approved_homes", force: :cascade do |t|
    t.string   "condo_name"
    t.string   "va_condo_id"
    t.string   "detail_uri"
    t.string   "address"
    t.string   "status"
    t.datetime "last_update"
    t.datetime "request_received_date"
    t.datetime "request_completion_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "lob_address_id"
    t.index ["lob_address_id"], name: "index_approved_homes_on_lob_address_id", using: :btree
  end

  create_table "lob_addresses", force: :cascade do |t|
    t.string   "lob_data_address_line1"
    t.string   "lob_data_address_line2"
    t.string   "lob_data_address_city"
    t.string   "lob_data_address_state"
    t.string   "lob_data_address_zip"
    t.string   "lob_data_address_country"
    t.string   "lob_data_object"
    t.string   "lob_data_message"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
