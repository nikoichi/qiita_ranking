class RenameStockTotalCountColumnToStockTotalCounts < ActiveRecord::Migration[5.1]
  def change
    rename_column :stock_total_counts, :stock_total_count, :total_count
  end
end
