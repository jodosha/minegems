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

ActiveRecord::Schema.define(:version => 20101218172104) do

  create_table "employments", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.boolean  "admin",           :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employments", ["organization_id", "user_id"], :name => "index_employments_on_organization_id_and_user_id", :unique => true

  create_table "organizations", :force => true do |t|
    t.string   "nickname"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["nickname"], :name => "index_organizations_on_nickname"

  create_table "rubygems", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "rubygems", ["name"], :name => "index_rubygems_on_name", :unique => true
  add_index "rubygems", ["organization_id"], :name => "index_rubygems_on_organization_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

  create_table "versions", :force => true do |t|
    t.integer  "rubygem_id"
    t.string   "number"
    t.string   "platform"
    t.boolean  "latest",     :default => true,  :null => false
    t.boolean  "prerelease", :default => false, :null => false
    t.boolean  "indexed",    :default => false, :null => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["indexed"], :name => "index_versions_on_indexed"
  add_index "versions", ["position"], :name => "index_versions_on_position"
  add_index "versions", ["rubygem_id", "latest"], :name => "index_versions_on_rubygem_id_and_latest", :unique => true
  add_index "versions", ["rubygem_id"], :name => "index_versions_on_rubygem_id"

end
