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

ActiveRecord::Schema.define(:version => 20121204203026) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

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
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "status",                :default => "active"
    t.string   "prefix"
    t.integer  "probability_impact_11", :default => 1
    t.integer  "probability_impact_12", :default => 1
    t.integer  "probability_impact_13", :default => 1
    t.integer  "probability_impact_21", :default => 1
    t.integer  "probability_impact_22", :default => 1
    t.integer  "probability_impact_23", :default => 1
    t.integer  "probability_impact_31", :default => 1
    t.integer  "probability_impact_32", :default => 1
    t.integer  "probability_impact_33", :default => 1
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
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.string   "status",                           :default => "active"
    t.datetime "create_date"
    t.text     "root_cause"
    t.text     "mitigation"
    t.text     "contingency"
    t.integer  "probability"
    t.integer  "cost"
    t.integer  "schedule"
    t.integer  "technical"
    t.integer  "risk_rating"
    t.date     "early_impact"
    t.date     "last_impact"
    t.integer  "days_to_impact"
    t.string   "type"
    t.string   "critical_path"
    t.string   "wbs_spec"
    t.text     "comment"
    t.integer  "creator_id"
    t.integer  "notification_before_early_impact"
    t.string   "triggers"
    t.string   "strategy"
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

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
