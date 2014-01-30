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

ActiveRecord::Schema.define(version: 20140129233906) do

  create_table "feeds", force: true do |t|
    t.string   "uid"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "feed_id"
    t.text     "content",    limit: 104857600
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "feed_uid"
  end

  create_table "user_feeds", force: true do |t|
    t.integer  "user_id"
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "uid"
    t.string   "provider"
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secret"
    t.string   "token"
  end

end
