# frozen_string_literal: true

class CreateQiitaTagErrorLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :qiita_tag_error_logs do |t|
      t.references :qiita_tag, foreign_key: true, null: false
      t.string :error_message
      t.string :error_type
      t.timestamps
    end
  end
end
