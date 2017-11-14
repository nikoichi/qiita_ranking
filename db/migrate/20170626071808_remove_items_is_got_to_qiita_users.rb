# frozen_string_literal: true

class RemoveItemsIsGotToQiitaUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :qiita_users, :items_is_got, :boolean
  end
end
