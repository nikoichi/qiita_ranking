# frozen_string_literal: true

class RenameItemsCountWhenAcquiredToQiitaUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :qiita_users, :items_count_when_acquired, :obtained_item_number
  end
end
