class RankingController < ApplicationController
  def show
    tag_id = params[:id] || QiitaTag::RUBY_ID
    @items = QiitaTag.find(tag_id).items.order(:likes_count).limit(10)
  end
end
