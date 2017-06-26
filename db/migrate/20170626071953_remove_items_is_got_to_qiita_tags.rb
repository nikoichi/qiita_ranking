class RemoveItemsIsGotToQiitaTags < ActiveRecord::Migration[5.1]
  def change
    remove_column :qiita_tags, :items_is_got, :boolean
  end
end
