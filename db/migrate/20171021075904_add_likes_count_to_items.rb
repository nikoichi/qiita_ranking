# frozen_string_literal: true

class AddLikesCountToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :likes_count, :integer
  end
end
