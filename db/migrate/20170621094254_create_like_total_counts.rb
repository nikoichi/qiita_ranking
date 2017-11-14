# frozen_string_literal: true

class CreateLikeTotalCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :like_total_counts do |t|
      t.integer :like_total_count, null: false
      t.references :item, foreign_key: true, null: false
      t.timestamps
    end
  end
end
