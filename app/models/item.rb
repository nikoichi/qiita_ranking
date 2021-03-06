# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :qiita_user
  has_many :item_qiita_tags
  has_many :qiita_tags, through: :item_qiita_tags
  has_many :stock_users, through: :qiita_user_stocks, class_name: 'QiitaUser', foreign_key: 'qiita_user_id'

  SEARCH_YEARS_NUMBER = 10
  DEFAULT_LIKES_COUNT = 0

  scope :search_by_tag_id, lambda { |tag_id|
    joins(qiita_tags: :tag_qiita_tags).where('tag_id = ?', tag_id) if tag_id.present?
  }

  scope :search_by_year, lambda { |year|
    where('items.qiita_created_at BETWEEN ? AND ?', "#{year}-01-01", "#{year}-12-31") if year.present?
  }

  # qiita_tagと中間テーブルも同時にupdate。qiita_tagがない場合はcreateする。
  def self.update_or_create(response_item)
    item_params = make_params(response_item)
    item = Item.find_or_initialize_by(qiita_item_id: item_params['qiita_item_id'])
    item.update!(item_params)
    item.update_stocks_count_and_total_count!
    item
  end

  def self.make_params(response_item)
    # キーをリネーム：id→qiita_item_id, private→is_private, created_at→qiita_created_at, updated_at→qiita_updated_at
    response_item['qiita_item_id'] = response_item.delete('id')
    response_item['is_private'] = response_item.delete('private')
    response_item['qiita_created_at'] = response_item.delete('created_at')
    response_item['qiita_updated_at'] = response_item.delete('updated_at')
    # body,coediting,group消去
    response_item.delete('body')
    response_item.delete('coediting')
    response_item.delete('group')
    # response_item['user']にqiita_userのインスタンス変数をセット
    response_user = response_item.delete('user')
    response_item['qiita_user'] = QiitaUser.update_or_create(response_user)
    # rendered_bodyからhtmlタグと改行を除去してdescriptionに保存
    rendered_body = response_item.delete('rendered_body')
    response_item['description'] = Sanitize.clean(rendered_body).gsub(/(\r\n|\r|\n|\f)/, '').slice(0..499)
    # tagsを消去&タグがない場合はcreate
    qiita_tag_names = response_item.delete('tags').map { |tag| tag['name'] }
    response_item['qiita_tag_ids'] = QiitaTag.get_tag_ids(qiita_tag_names)
    response_item
  end

  def update_stocks_count_and_total_count!
    stocks_count = QiitaApiTask.get_stocks_count qiita_item_id
    total_count = stocks_count + (likes_count || DEFAULT_LIKES_COUNT)
    update!(stocks_count: stocks_count,
            stocks_count_updated_at: Time.zone.now,
            total_count: total_count)
  end
end
