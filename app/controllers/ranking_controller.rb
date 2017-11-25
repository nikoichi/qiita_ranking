# frozen_string_literal: true

class RankingController < ApplicationController
  def index
    @categories = Category.includes(:tags)
    @item_search = ItemSearch.new(item_search_params)
    # TODO: ソート方法いいね・ストック・合計から選びたい
    order_option = 'total_count'
    @items = @item_search.search_items.order(order_option + ' DESC').limit(10)
  end

  private

  def item_search_params
    params.permit(:tag_id, :year)
  end
end
