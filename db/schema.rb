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

ActiveRecord::Schema.define(:version => 20130212121703) do

  create_table "achievements", :force => true do |t|
    t.string   "name"
    t.string   "pic_path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "achievements_activities", :id => false, :force => true do |t|
    t.integer "achievement_id"
    t.integer "activity_id"
  end

  add_index "achievements_activities", ["achievement_id", "activity_id"], :name => "index_achievements_activities_on_achievement_id_and_activity_id"
  add_index "achievements_activities", ["activity_id", "achievement_id"], :name => "index_achievements_activities_on_activity_id_and_achievement_id"

  create_table "achievements_users", :id => false, :force => true do |t|
    t.integer "achievement_id"
    t.integer "user_id"
  end

  add_index "achievements_users", ["achievement_id", "user_id"], :name => "index_achievements_users_on_achievement_id_and_user_id"
  add_index "achievements_users", ["user_id", "achievement_id"], :name => "index_achievements_users_on_user_id_and_achievement_id"

  create_table "action_posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "comment"
    t.string   "place"
    t.integer  "score"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.boolean  "public",                                    :default => false
  end

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "pic_path"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "has_price",       :default => false
    t.boolean  "has_place",       :default => false
    t.boolean  "has_score",       :default => false
    t.boolean  "has_comment",     :default => false
    t.boolean  "has_duration",    :default => false
    t.string   "past_participle"
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
  end

  create_table "microposts", :force => true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "public",     :default => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
