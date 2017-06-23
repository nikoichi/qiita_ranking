class QiitaUser < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :stocks, through: :qiita_user_stocks, class_name: 'ITem', foreign_key: 'item_id'
end
