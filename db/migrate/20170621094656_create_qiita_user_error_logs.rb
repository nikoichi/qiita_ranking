# frozen_string_literal: true

class CreateQiitaUserErrorLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :qiita_user_error_logs do |t|
      t.references :qiita_user, foreign_key: true, null: false
      t.string :error_message
      t.string :error_type
      t.timestamps
    end
  end
end
