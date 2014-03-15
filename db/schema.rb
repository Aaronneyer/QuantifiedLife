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

ActiveRecord::Schema.define(version: 20140315190332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: true do |t|
    t.date     "date"
    t.string   "headline"
    t.text     "summary"
    t.string   "start_location"
    t.string   "end_location"
    t.integer  "impact"
    t.json     "extra_info"
    t.json     "moves_storyline"
    t.json     "moves_summary"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "github_events", force: true do |t|
    t.json     "event"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_id"
    t.integer  "user_id"
  end

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "caption"
    t.string   "s3_url"
    t.string   "filename"
    t.datetime "datetime"
    t.string   "dropbox_path"
    t.json     "exif"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.date     "date"
    t.integer  "impact"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tags",       default: [], array: true
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "confirmation_token"
    t.string   "remember_token"
    t.string   "github_token"
    t.boolean  "github_private"
    t.string   "dropbox_token"
    t.string   "dropbox_uid"
    t.string   "moves_token"
    t.json     "extra_info"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locations",          default: [], array: true
    t.integer  "permitted_viewers",  default: [], array: true
  end

end
