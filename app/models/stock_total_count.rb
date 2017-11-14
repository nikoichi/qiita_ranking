# frozen_string_literal: true

class StockTotalCount < ApplicationRecord
  belongs_to :item

  def self.update_or_create(item_id, total_count)
    stock_total_count = StockTotalCount.find_or_initialize_by(item_id: item_id)
    stock_total_count.update!(total_count: total_count)
    stock_total_count
  end
end
