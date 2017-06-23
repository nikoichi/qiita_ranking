class QiitaUser < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :stocks, through: :qiita_user_stocks, class_name: 'ITem', foreign_key: 'item_id'

  # TODO: 例外処理記載
  def self.make_params(body)
    # キー'id'を'nickname'にリネーム
    body['nickname'] = body.delete('id')
    if body['organization'].present?
      body['organization'] = Organization.find_or_create_by(name: body['organization'])
    else
      body['organization'] = nil
    end
    body
  end
end
