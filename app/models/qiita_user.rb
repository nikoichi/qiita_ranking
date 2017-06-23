class QiitaUser < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :stocks, through: :qiita_user_stocks, class_name: 'ITem', foreign_key: 'item_id'

  def self.update_or_create(response_user)
    qiita_user_params = make_params(response_user)
    qiita_user = QiitaUser.find_or_initialize_by(nickname: qiita_user_params['nickname'])
    qiita_user.update!(qiita_user_params)
    qiita_user
  end

  def self.make_params(response_user)
    # キー'id'を'nickname'にリネーム
    response_user['nickname'] = response_user.delete('id')
    # organizationにOrganizationモデルのインスタンス変数をセット
    if response_user['organization'].present?
      response_user['organization'] = Organization.find_or_create_by(name: response_user['organization'])
    else
      response_user['organization'] = nil
    end
    response_user
  end
end
