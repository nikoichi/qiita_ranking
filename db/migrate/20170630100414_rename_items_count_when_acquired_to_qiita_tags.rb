# frozen_string_literal: true

class RenameItemsCountWhenAcquiredToQiitaTags < ActiveRecord::Migration[5.1]
  def change
    rename_column :qiita_tags, :items_count_when_acquired, :obtained_item_number
  end
end
