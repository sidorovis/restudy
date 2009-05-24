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

ActiveRecord::Schema.define(:version => 20090518070302) do

  create_table "integer_variables", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_integer"
    t.boolean  "is_string"
    t.integer  "string_variable_id"
    t.integer  "integer_variable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scenarios", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "rule_id"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "string_variables", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
