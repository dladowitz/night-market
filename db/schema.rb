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

ActiveRecord::Schema.define(version: 20150103011626) do

  create_table "dishes", force: true do |t|
    t.string   "name",             null: false
    t.integer  "meal_id",          null: false
    t.string   "vendor"
    t.integer  "servings"
    t.string   "category"
    t.boolean  "needs_ordering"
    t.boolean  "ordered"
    t.boolean  "vegetarian"
    t.boolean  "vegan"
    t.boolean  "gluten_free"
    t.boolean  "needs_ice"
    t.boolean  "ignore_warnings"
    t.string   "transport_method"
    t.datetime "transport_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name",        null: false
    t.integer  "guests",      null: false
    t.integer  "user_id"
    t.string   "location"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "budget"
    t.boolean  "gluten_free"
    t.boolean  "vegetarian"
    t.boolean  "vegan"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", force: true do |t|
    t.string   "category",        null: false
    t.integer  "event_id",        null: false
    t.integer  "cost"
    t.integer  "guests"
    t.datetime "start"
    t.boolean  "ignore_warnings"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplies", force: true do |t|
    t.string   "name"
    t.integer  "event_id"
    t.boolean  "purchased"
    t.string   "vendor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
