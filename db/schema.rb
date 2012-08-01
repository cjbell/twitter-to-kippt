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

ActiveRecord::Schema.define(:version => 20120801094323) do

  create_table "users", :force => true do |t|
    t.string   "twitter_uid"
    t.string   "twitter_username"
    t.string   "kippt_username"
    t.string   "twitter_token"
    t.string   "kippt_token"
    t.string   "last_tweet_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "twitter_secret"
    t.string   "twitter_avatar"
    t.datetime "time_of_last_sync"
    t.string   "kippt_list_id"
  end

end
