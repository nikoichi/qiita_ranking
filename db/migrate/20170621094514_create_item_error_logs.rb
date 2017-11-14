# frozen_string_literal: true

class CreateItemErrorLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :item_error_logs do |t|
      t.references :item, foreign_key: true, null: false
      t.string :error_message
      t.string :error_type
      t.timestamps
    end
  end
end
