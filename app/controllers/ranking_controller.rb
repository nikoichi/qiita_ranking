class RankingController < ApplicationController
  def index
    tag_id = params[:id] || QiitaTag::RUBY_ID
    @items = QiitaTag.find(tag_id).items.order(:likes_count).limit(10)

    # item_search = ItemSearch.new(item_search_params)
    # @items = item_search.search_items
  end

  private

  def item_search_params

  end
end
