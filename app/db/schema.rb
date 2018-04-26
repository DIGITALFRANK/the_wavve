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

ActiveRecord::Schema.define(version: 2018_04_26_220417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.string "media_url"
    t.string "text_content"
    t.integer "user_id"
  end

  create_table "postssubtags", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
    t.integer "subtag_id"
  end

  create_table "poststags", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  create_table "subtags", force: :cascade do |t|
    t.string "subtag_name"
    t.string "tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "industry"
    t.string "title"
    t.string "email"
    t.string "password"
  end

end
