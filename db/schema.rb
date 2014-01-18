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

ActiveRecord::Schema.define(version: 20140118201547) do

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
    t.json     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string "caption"
    t.string "filepicker_url"
    t.string "filename"
    t.date   "date"
    t.string "dropbox_url"
    t.json   "exif"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.date     "date"
    t.integer  "impact"
    t.string   "tags"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "location_string",    default: ""
  end

end
