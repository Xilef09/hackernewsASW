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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160501150613) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "puntos"
    t.integer  "user_id"
    t.integer  "contribution_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "comments", ["contribution_id", "created_at"], name: "index_comments_on_contribution_id_and_created_at"
  add_index "comments", ["contribution_id"], name: "index_comments_on_contribution_id"
  add_index "comments", ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "contributions", force: :cascade do |t|
    t.string   "titulo"
    t.string   "url"
    t.integer  "puntos"
    t.text     "text"
    t.string   "tipo"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contributions", ["user_id", "created_at"], name: "index_contributions_on_user_id_and_created_at"
  add_index "contributions", ["user_id"], name: "index_contributions_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.text     "content"
    t.integer  "puntos"
    t.integer  "user_id"
    t.integer  "contribution_id"
    t.integer  "comment_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "replies", ["comment_id", "created_at"], name: "index_replies_on_comment_id_and_created_at"
  add_index "replies", ["comment_id"], name: "index_replies_on_comment_id"
  add_index "replies", ["contribution_id"], name: "index_replies_on_contribution_id"
  add_index "replies", ["user_id", "created_at"], name: "index_replies_on_user_id_and_created_at"
  add_index "replies", ["user_id"], name: "index_replies_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.text     "about"
    t.integer  "karma"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
