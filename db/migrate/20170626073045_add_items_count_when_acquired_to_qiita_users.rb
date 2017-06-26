class AddItemsCountWhenAcquiredToQiitaUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :qiita_users, :items_count_when_acquired, :integer, after: :items_count
  end
end
