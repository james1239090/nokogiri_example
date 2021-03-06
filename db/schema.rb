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

ActiveRecord::Schema.define(version: 20160731092719) do

  create_table "dists", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trunk_lines", force: :cascade do |t|
    t.string   "respond_area"
    t.integer  "car_no"
    t.integer  "number"
    t.string   "dist"
    t.string   "vil"
    t.string   "address"
    t.string   "around_time"
    t.string   "recover_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "full_address"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "villages", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
