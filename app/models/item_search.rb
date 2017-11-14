# frozen_string_literal: true

class ItemSearch
  include ActiveModel::Model

  attr_accessor :tag_ids, :year, :qiita_tag_ids, :qiita_user_ids

  def search_items
    Item.search_by_qiita_tag_ids(qiita_tag_ids)
        .search_by_year(year)
  end
end
