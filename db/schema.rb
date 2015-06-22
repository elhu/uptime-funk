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

ActiveRecord::Schema.define(version: 20150617193243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "operators", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.string   "weather_url"
    t.string   "website"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "content_type"
  end

  create_table "outages", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "operator_id"
    t.integer  "duration"
    t.string   "line"
    t.string   "type"
    t.string   "cause"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "outages", ["finished_at"], name: "index_outages_on_finished_at", using: :btree
  add_index "outages", ["line"], name: "index_outages_on_line", using: :btree
  add_index "outages", ["operator_id"], name: "index_outages_on_operator_id", using: :btree
  add_index "outages", ["started_at"], name: "index_outages_on_started_at", using: :btree
  add_index "outages", ["type"], name: "index_outages_on_type", using: :btree

  create_table "weather_reports", force: :cascade do |t|
    t.jsonb    "report"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "operator_id"
  end

end
