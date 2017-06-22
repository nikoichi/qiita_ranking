class CreateQiitaUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :qiita_users do |t|
      t.string :nickname, null: false
      t.integer :permanent_id, null: false
      t.string :name
      t.string :facebook_id
      t.string :github_login_name
      t.string :linkedin_id
      t.string :twitter_screen_name
      t.references :organization, foreign_key: true
      t.string :profile_image_url
      t.string :website_url
      t.string :location
      t.text :description
      t.integer :followees_count, null: false
      t.integer :followers_count, null: false
      t.integer :items_count, null: false
      t.boolean :items_is_got, null: false, default: false
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :qiita_users, :nickname, unique: true
    add_index :qiita_users, :permanent_id, unique: true
  end
end
