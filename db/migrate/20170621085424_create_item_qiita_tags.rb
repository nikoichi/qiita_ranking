class CreateItemQiitaTags < ActiveRecord::Migration[5.1]
  def change
    create_table :item_qiita_tags do |t|
      t.references :item, foreign_key: true, null: false
      t.references :qiita_tag, foreign_key: true, null: false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
