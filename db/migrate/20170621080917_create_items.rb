class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :qiita_item_id, null: false
      t.string :title, null: false
      t.references :qiita_user, foreign_key: true, null: false
      t.string :url, null: false
      t.boolean :is_private, null: false, default: false
      t.text :description
      t.datetime :qiita_created_at, null: false
      t.datetime :qiita_updated_at, null: false
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :items, :qiita_item_id, unique: true
  end
end
