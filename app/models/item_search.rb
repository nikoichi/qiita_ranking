class ItemSearch < ApplicationRecord
  include ActiveModel::Model

  #year:対象の年の初日が格納されている
  attr_accessor :tag_ids, :year, :qiita_tag_ids, :qiita_user_ids

  def self.search_items
    Items.search_by_qiita_tag_ids(qiita_tag_ids)
         .search_by_years(year)
  end
end
