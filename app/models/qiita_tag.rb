class QiitaTag < ApplicationRecord
  has_many :items, through: :item_qiita_tags

  def self.update_or_create(response_tag_params)
    qiita_tag_params = make_params(response_tag_params)
    qiita_tag = QiitaTag.find_or_initialize_by(name: qiita_tag_params['name'])
    qiita_tag.update!(qiita_tag_params)
  end

  def self.make_params(response_tag_params)
    # キー'id'を'name'にリネーム
    response_tag_params['name'] = response_tag_params.delete('id')
    response_tag_params
  end
end
