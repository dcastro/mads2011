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

ActiveRecord::Schema.define(:version => 20111130173155) do

  create_table "example_cells", :force => true do |t|
    t.integer  "example_row_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "example_rows", :force => true do |t|
    t.integer  "scenario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examples", :force => true do |t|
    t.integer  "scenario_id"
    t.text     "keyword"
    t.text     "name"
    t.text     "description"
    t.integer  "line"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", :force => true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "done"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "repo"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scenarios", :force => true do |t|
    t.integer  "feature_id"
    t.string   "name"
    t.integer  "line"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "completed"
    t.string   "type"
  end

  create_table "step_cells", :force => true do |t|
    t.integer  "step_row_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "step_rows", :force => true do |t|
    t.integer  "step_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", :force => true do |t|
    t.integer  "scenario_id"
    t.string   "keyword"
    t.string   "name"
    t.integer  "line"
    t.string   "location"
    t.string   "status"
    t.text     "error_msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestion_cells", :force => true do |t|
    t.integer  "suggestion_row_id"
    t.integer  "cell_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "suggestion_rows", :force => true do |t|
    t.integer  "suggestion_step_id"
    t.integer  "row_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestion_scenarios", :force => true do |t|
    t.integer  "feature_id"
    t.integer  "user_id"
    t.text     "description"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestion_steps", :force => true do |t|
    t.integer  "suggestion_scenario_id"
    t.string   "name"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "name"
    t.string   "email"
    t.string   "contact"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
