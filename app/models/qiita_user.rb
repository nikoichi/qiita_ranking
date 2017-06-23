class QiitaUser < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :stocks, through: :qiita_user_stocks, class_name: 'ITem', foreign_key: 'item_id'

  def self.update_or_create(response_user_params)
    qiita_user_params = make_params(response_user_params)
    qiita_user = QiitaUser.find_or_initialize_by(nickname: qiita_user_params['nickname'])
    qiita_user.update!(qiita_user_params)
    # TODO: 例外処理記載
  end

  def self.make_params(response_user_params)
    # キー'id'を'nickname'にリネーム
    response_user_params['nickname'] = response_user_params.delete('id')
    if response_user_params['organization'].present?
      response_user_params['organization'] = Organization.find_or_create_by(name: response_user_params['organization'])
    else
      response_user_params['organization'] = nil
    end
    response_user_params
  end
end
