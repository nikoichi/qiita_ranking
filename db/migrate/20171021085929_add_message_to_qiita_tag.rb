# frozen_string_literal: true

class AddMessageToQiitaTag < ActiveRecord::Migration[5.1]
  def change
    add_column :qiita_tags, :message, :text
  end
end
