class CreateQiitaUserStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :qiita_user_stocks do |t|
      t.references :qiita_user, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
