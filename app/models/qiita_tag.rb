class QiitaTag < ApplicationRecord
  has_many :items, through: :item_qiita_tags

  # TODO: 例外処理記載
  def self.make_params(body)
    # キー'id'を'name'にリネーム
    body['name'] = body.delete('id')
    body
  end
end
