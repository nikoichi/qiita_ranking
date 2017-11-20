# frozen_string_literal: true

class ItemSearch
  include ActiveModel::Model

  attr_accessor :tag_id, :year, :qiita_user_ids

  def search_items
    Item.search_by_tag(tag_id)
        .search_by_year(year)
  end
end
