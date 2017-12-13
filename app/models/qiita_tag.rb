# frozen_string_literal: true

class QiitaTag < ApplicationRecord
  has_many :item_qiita_tags
  has_many :items, through: :item_qiita_tags
  has_many :tags, through: :tag_qiita_tags
  has_many :tag_qiita_tags
  RUBY_ID = 1

  def self.update_or_create(response_tag)
    qiita_tag_params = make_params(response_tag)
    qiita_tag = QiitaTag.find_or_initialize_by(name: qiita_tag_params['name'])
    qiita_tag.update!(qiita_tag_params)
    qiita_tag
  end

  def self.make_params(response_tag)
    # キー'id'を'name'にリネーム
    response_tag['name'] = response_tag.delete('id')
    response_tag
  end

  def self.get_tag_ids(qiita_tag_names)
    qiita_tag_names.map do |qiita_tag_name|
      qiita_tag = find_by(name: qiita_tag_name)
      # タグがレコードにない場合は作成する
      if qiita_tag.blank?
        client = Qiita::Client.new(access_token: Rails.application.secrets.qiita_access_token)
        response = client.get_tag(qiita_tag_name)
        ap response_tag = response.body
        qiita_tag = update_or_create(response_tag)
        # TODO: 例外処理記載
        logger '【get_tag】'
        ap response.headers
        ap response.status
      end
      qiita_tag.id
    end
  end
end
