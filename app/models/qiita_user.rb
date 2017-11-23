# frozen_string_literal: true

class QiitaUser < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :stocks, through: :qiita_user_stocks, class_name: 'Item', foreign_key: 'item_id'

  def self.update_or_create(response_user)
    qiita_user_params = make_params(response_user)
    qiita_user = QiitaUser.find_or_initialize_by(permanent_id: qiita_user_params['permanent_id'])
    qiita_user.update!(qiita_user_params)
    qiita_user
  end

  def self.make_params(response_user)
    # キー'id'を'nickname'にリネーム
    response_user['nickname'] = response_user.delete('id')
    # organizationにOrganizationモデルのインスタンス変数をセット
    response_user['organization'] = if response_user['organization'].present?
                                      Organization.find_or_create_by(name: response_user['organization'])
                                    end
    response_user
  end
end
