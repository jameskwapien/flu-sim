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

ActiveRecord::Schema.define(version: 20160417164427) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "post_id",    limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name",       limit: 30
    t.integer  "crn",        limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "instructor", limit: 255
    t.string   "email",      limit: 255
    t.integer  "days",       limit: 4
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "course_id",  limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "member_id",       limit: 4,   null: false
    t.string   "member_type",     limit: 255, null: false
    t.integer  "group_id",        limit: 4
    t.string   "group_type",      limit: 255
    t.string   "group_name",      limit: 255
    t.string   "membership_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_memberships", ["group_name"], name: "index_group_memberships_on_group_name", using: :btree
  add_index "group_memberships", ["group_type", "group_id"], name: "index_group_memberships_on_group_type_and_group_id", using: :btree
  add_index "group_memberships", ["member_type", "member_id"], name: "index_group_memberships_on_member_type_and_member_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string  "type",      limit: 255
    t.string  "name",      limit: 255
    t.integer "course_id", limit: 4
  end

  create_table "inputs", force: :cascade do |t|
    t.string   "group_name", limit: 30
    t.integer  "vaccines",   limit: 4
    t.integer  "school_off", limit: 4
    t.integer  "days",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seed",       limit: 4
    t.integer  "ads",        limit: 4
    t.integer  "money_left", limit: 4
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "outputs", force: :cascade do |t|
    t.string   "group_name",           limit: 30
    t.decimal  "money_left",                      precision: 64, scale: 12
    t.decimal  "money_spent_vaccines",            precision: 64, scale: 12
    t.decimal  "money_spent_ads",                 precision: 64, scale: 12
    t.integer  "vaccs_left",           limit: 4
    t.integer  "population",           limit: 4
    t.integer  "sick",                 limit: 4
    t.integer  "immune",               limit: 4
    t.integer  "pop_age0",             limit: 4
    t.integer  "sick_age0",            limit: 4
    t.integer  "pop_age1",             limit: 4
    t.integer  "sick_age1",            limit: 4
    t.integer  "pop_age2",             limit: 4
    t.integer  "sick_age2",            limit: 4
    t.integer  "day",                  limit: 4
    t.integer  "cityID",               limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "input_id",             limit: 4
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "simulations", force: :cascade do |t|
    t.integer  "input",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "instructor",                         default: false
    t.string   "name",                   limit: 255
    t.boolean  "admin",                              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "posts", "users"
end
