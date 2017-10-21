class RankingController < ApplicationController
  def show
    tag_id = params[:id] || QiitaTag::RUBY_ID
    @items = QiitaTag.find(tag_id).items.where(qiita_user_id: 2)
  end
end
