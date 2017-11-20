# frozen_string_literal: true

class RankingController < ApplicationController
  def index
    @categories = Category.includes(:tags)
    @item_search = ItemSearch.new(item_search_params)
    @items = @item_search.search_items.limit(10)
  end

  private

  def item_search_params
    params.permit(:tag_id, :year)
  end
end
