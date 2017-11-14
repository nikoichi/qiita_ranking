# frozen_string_literal: true

class AddItemsCountWhenAcquiredToQiitaTags < ActiveRecord::Migration[5.1]
  def change
    add_column :qiita_tags, :items_count_when_acquired, :integer, after: :followers_count
  end
end
