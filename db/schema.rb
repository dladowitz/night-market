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

ActiveRecord::Schema.define(version: 20141105225133) do

  create_table "dishes", force: true do |t|
    t.string   "name",             null: false
    t.integer  "meal_id",          null: false
    t.string   "vendor"
    t.integer  "servings"
    t.string   "category"
    t.boolean  "ordered"
    t.boolean  "vegetarian"
    t.boolean  "vegan"
    t.boolean  "gluten_free"
    t.boolean  "dairy_free"
    t.boolean  "needs_ice"
    t.string   "transport_method"
    t.string   "transport_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name",        null: false
    t.integer  "guests",      null: false
    t.string   "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "budget"
    t.boolean  "gluten_free"
    t.boolean  "vegetarian"
    t.boolean  "vegan"
    t.boolean  "dairy_free"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", force: true do |t|
    t.string   "category",   null: false
    t.integer  "event_id",   null: false
    t.integer  "guests"
    t.datetime "start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
