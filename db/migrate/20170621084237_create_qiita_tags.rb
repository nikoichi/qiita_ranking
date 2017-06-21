class CreateQiitaTags < ActiveRecord::Migration[5.1]
  def change
    create_table :qiita_tags do |t|
      t.string :name, null: false
      t.string :icon_url
      t.integer :items_count, null: false
      t.integer :followers_count, null: false
      t.boolean :items_is_got, null: false, default: false
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :qiita_tags, :name, unique: true
  end
end
