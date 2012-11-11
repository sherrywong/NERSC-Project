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

ActiveRecord::Schema.define(:version => 20121110182757) do

  create_table "project_memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.boolean  "owner",      :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "permission", :default => "read"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "status",      :default => "active"
  end

  create_table "risk_logs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "risk_id"
    t.text     "description"
    t.string   "field"
    t.string   "username"
    t.datetime "updated_on"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "risks", :force => true do |t|
    t.integer  "project_id"
    t.integer  "owner_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "status",         :default => "active"
    t.string   "short_title"
    t.datetime "create_date"
    t.text     "root_cause"
    t.text     "mitigation"
    t.text     "contingency"
    t.integer  "probability"
    t.integer  "cost"
    t.integer  "schedule"
    t.integer  "technical"
    t.integer  "other_type"
    t.integer  "risk_rating"
    t.date     "early_impact"
    t.date     "last_impact"
    t.integer  "days_to_impact"
    t.string   "type"
    t.string   "critical_path"
    t.string   "wbs_spec"
    t.text     "comment"
  end

  create_table "users", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.boolean  "admin",           :default => false
    t.string   "username"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "password_digest"
    t.string   "status",          :default => "active"
  end

end
