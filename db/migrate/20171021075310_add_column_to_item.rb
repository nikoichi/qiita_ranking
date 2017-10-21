class AddColumnToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :comments_count, :integer
  end
end
