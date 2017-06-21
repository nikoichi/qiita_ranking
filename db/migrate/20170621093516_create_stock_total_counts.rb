class CreateStockTotalCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_total_counts do |t|
      t.integer :stock_total_count, null: false
      t.references :item, foreign_key: true, null: false
      t.timestamps
    end
  end
end
