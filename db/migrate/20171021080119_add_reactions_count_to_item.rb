# frozen_string_literal: true

class AddReactionsCountToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :reactions_count, :integer
  end
end
