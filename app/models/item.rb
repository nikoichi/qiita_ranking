class Item < ApplicationRecord
  belongs_to :qiita_user
  has_many :item_qiita_tags
  has_many :qiita_tags, through: :item_qiita_tags
  has_many :stock_users, through: :qiita_user_stocks, class_name: 'QiitaUser', foreign_key: 'qiita_user_id'

  # qiita_tagと中間テーブルも同時にupdate。qiita_tagがない場合はcreateする。
  def self.update_or_create(response_item_params)
    item_params = make_params(response_item_params)
    item = Item.find_or_initialize_by(qiita_item_id: response_item_params['qiita_item_id'])
    item.update!(response_item_params)
  end

  def self.make_params(response_item_params)
    # キーをリネーム：id→qiita_item_id, private→is_private, created_at→qiita_created_at, updated_at→qiita_updated_at
    response_item_params['qiita_item_id'] = response_item_params.delete('id')
    response_item_params['is_private'] = response_item_params.delete('private')
    response_item_params['qiita_created_at'] = response_item_params.delete('created_at')
    response_item_params['qiita_updated_at'] = response_item_params.delete('updated_at')
    # body,coediting,group消去
    response_item_params.delete('body')
    response_item_params.delete('coediting')
    response_item_params.delete('group')
    # response_item_params['user']にqiita_userのインスタンス変数をセット
    response_user_params = response_item_params.delete('user')
    response_item_params['qiita_user'] = QiitaUser.update_or_create(response_user_params)
    # rendered_bodyからhtmlタグと改行を除去してdescriptionに保存
    rendered_body = response_item_params.delete('rendered_body')
    response_item_params['description'] = Sanitize.clean(rendered_body).gsub(/(\r\n|\r|\n|\f)/, '').slice(0..499)
    # tagsを消去&タグがない場合はcreate
    qiita_tag_names = response_item_params.delete('tags').map { |tag| tag['name'] }
    response_item_params['qiita_tag_ids'] = QiitaTag.get_tag_ids(qiita_tag_names)
  end
end
