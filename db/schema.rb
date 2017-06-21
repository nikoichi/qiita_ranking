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

ActiveRecord::Schema.define(version: 20170621085424) do

  create_table "item_qiita_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "item_id", null: false
    t.bigint "qiita_tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["item_id"], name: "index_item_qiita_tags_on_item_id"
    t.index ["qiita_tag_id"], name: "index_item_qiita_tags_on_qiita_tag_id"
  end

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "qiita_item_id", null: false
    t.string "title", null: false
    t.bigint "qiita_user_id", null: false
    t.string "url", null: false
    t.boolean "is_private", default: false, null: false
    t.text "description"
    t.datetime "qiita_created_at", null: false
    t.datetime "qiita_updated_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["qiita_item_id"], name: "index_items_on_qiita_item_id", unique: true
    t.index ["qiita_user_id"], name: "index_items_on_qiita_user_id"
  end

  create_table "organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "qiita_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "icon_url"
    t.integer "items_count", null: false
    t.integer "followers_count", null: false
    t.boolean "items_is_got", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["name"], name: "index_qiita_tags_on_name", unique: true
  end

  create_table "qiita_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nickname", null: false
    t.integer "permanent_id", null: false
    t.string "name"
    t.string "facebook_id"
    t.string "github_id"
    t.string "linkedin_id"
    t.string "twitter_screen_id"
    t.bigint "organization_id"
    t.string "profile_image_url"
    t.string "website_url"
    t.string "location"
    t.text "description"
    t.integer "followees_count", null: false
    t.integer "followers_count", null: false
    t.integer "items_count", null: false
    t.boolean "items_is_got", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["nickname"], name: "index_qiita_users_on_nickname", unique: true
    t.index ["organization_id"], name: "index_qiita_users_on_organization_id"
    t.index ["permanent_id"], name: "index_qiita_users_on_permanent_id", unique: true
  end

  add_foreign_key "item_qiita_tags", "items"
  add_foreign_key "item_qiita_tags", "qiita_tags"
  add_foreign_key "items", "qiita_users"
  add_foreign_key "qiita_users", "organizations"
end
