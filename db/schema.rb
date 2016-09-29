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

ActiveRecord::Schema.define(version: 20160928010204) do

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",         limit: 100
    t.string   "line1",        limit: 50
    t.string   "line2",        limit: 50
    t.string   "city",         limit: 35
    t.string   "state",        limit: 20
    t.string   "zip",          limit: 11
    t.string   "phone",        limit: 20
    t.string   "phone_number", limit: 20
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["name", "line1", "line2", "city", "state", "zip", "phone_number"], name: "fulltext_search", type: :fulltext
  end

end
