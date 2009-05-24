# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090516115606) do

  create_table "bug_statuses", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bugs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "steps_to_reproduce"
    t.integer  "bug_status_id"
    t.integer  "build_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "build_statuses", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "builds", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "build_status_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issue_statuses", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "issue_status_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_statuses", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "project_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "right_templates", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "controller"
    t.string   "actions"
    t.string   "write_ids"
    t.string   "read_ids"
    t.integer  "role_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_templates", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "role_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_statuses", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "task_status_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.integer  "role_id"
  end

end
