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

ActiveRecord::Schema.define(:version => 20090227141055) do

  create_table "wf_attributes", :force => true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wf_attributes_word_forms", :id => false, :force => true do |t|
    t.integer "word_form_id"
    t.integer "wf_attribute_id"
  end

  create_table "word_forms", :force => true do |t|
    t.string   "content"
    t.integer  "word_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "word_groups", :force => true do |t|
    t.string   "template"
    t.integer  "word_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "word_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "words", :force => true do |t|
    t.string   "content"
    t.integer  "word_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
