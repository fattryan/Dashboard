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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111112063823) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.date     "birthday"
    t.string   "specialty"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.date     "date_started"
    t.string   "business_name"
    t.integer  "client_age"
  end

  create_table "quarters", :force => true do |t|
    t.integer  "client_id"
    t.integer  "quarter"
    t.integer  "year"
    t.integer  "production"
    t.integer  "collections"
    t.integer  "total_visits"
    t.integer  "new_patients"
    t.integer  "net_worth"
    t.integer  "income"
    t.integer  "qualified_savings"
    t.integer  "taxable_savings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_savings"
    t.integer  "personal_savings_rate"
  end

end
