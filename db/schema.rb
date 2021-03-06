# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_171_021_085_929) do
  create_table 'item_error_logs', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.bigint 'item_id', null: false
    t.string 'error_message'
    t.string 'error_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_item_error_logs_on_item_id'
  end

  create_table 'item_qiita_tags', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.bigint 'item_id', null: false
    t.bigint 'qiita_tag_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.index ['item_id'], name: 'index_item_qiita_tags_on_item_id'
    t.index ['qiita_tag_id'], name: 'index_item_qiita_tags_on_qiita_tag_id'
  end

  create_table 'items', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.string 'qiita_item_id', null: false
    t.string 'title', null: false
    t.bigint 'qiita_user_id', null: false
    t.string 'url', null: false
    t.boolean 'is_private', default: false, null: false
    t.text 'description'
    t.datetime 'qiita_created_at', null: false
    t.datetime 'qiita_updated_at', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.integer 'comments_count'
    t.integer 'likes_count'
    t.integer 'reactions_count'
    t.index ['qiita_item_id'], name: 'index_items_on_qiita_item_id', unique: true
    t.index ['qiita_user_id'], name: 'index_items_on_qiita_user_id'
  end

  create_table 'like_total_counts', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.integer 'like_total_count', null: false
    t.bigint 'item_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_like_total_counts_on_item_id'
  end

  create_table 'organizations', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_organizations_on_name', unique: true
  end

  create_table 'qiita_tag_error_logs', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.bigint 'qiita_tag_id', null: false
    t.string 'error_message'
    t.string 'error_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['qiita_tag_id'], name: 'index_qiita_tag_error_logs_on_qiita_tag_id'
  end

  create_table 'qiita_tags', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.string 'name', null: false
    t.string 'icon_url'
    t.integer 'items_count', null: false
    t.integer 'followers_count', null: false
    t.integer 'obtained_item_number'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.text 'message'
    t.index ['name'], name: 'index_qiita_tags_on_name', unique: true
  end

  create_table 'qiita_user_error_logs', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.bigint 'qiita_user_id', null: false
    t.string 'error_message'
    t.string 'error_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['qiita_user_id'], name: 'index_qiita_user_error_logs_on_qiita_user_id'
  end

  create_table 'qiita_user_stocks', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.bigint 'qiita_user_id', null: false
    t.bigint 'item_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.index ['item_id'], name: 'index_qiita_user_stocks_on_item_id'
    t.index ['qiita_user_id'], name: 'index_qiita_user_stocks_on_qiita_user_id'
  end

  create_table 'qiita_users', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.string 'nickname', null: false
    t.integer 'permanent_id', null: false
    t.string 'name'
    t.string 'facebook_id'
    t.string 'github_login_name'
    t.string 'linkedin_id'
    t.string 'twitter_screen_name'
    t.bigint 'organization_id'
    t.string 'profile_image_url'
    t.string 'website_url'
    t.string 'location'
    t.text 'description'
    t.integer 'followees_count', null: false
    t.integer 'followers_count', null: false
    t.integer 'items_count', null: false
    t.integer 'obtained_item_number'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.index ['nickname'], name: 'index_qiita_users_on_nickname', unique: true
    t.index ['organization_id'], name: 'index_qiita_users_on_organization_id'
    t.index ['permanent_id'], name: 'index_qiita_users_on_permanent_id', unique: true
  end

  create_table 'stock_total_counts', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4' do |t|
    t.integer 'total_count', null: false
    t.bigint 'item_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['item_id'], name: 'index_stock_total_counts_on_item_id'
  end

  add_foreign_key 'item_error_logs', 'items'
  add_foreign_key 'item_qiita_tags', 'items'
  add_foreign_key 'item_qiita_tags', 'qiita_tags'
  add_foreign_key 'items', 'qiita_users'
  add_foreign_key 'like_total_counts', 'items'
  add_foreign_key 'qiita_tag_error_logs', 'qiita_tags'
  add_foreign_key 'qiita_user_error_logs', 'qiita_users'
  add_foreign_key 'qiita_user_stocks', 'items'
  add_foreign_key 'qiita_user_stocks', 'qiita_users'
  add_foreign_key 'stock_total_counts', 'items'
end
