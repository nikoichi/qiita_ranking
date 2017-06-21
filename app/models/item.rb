class Item < ApplicationRecord
  belongs_to :qiita_user
  has_many :qiita_tags, through: :item_qiita_tags
  has_many :stock_users, through: :qiita_user_stocks, class_name: 'QiitaUser', foreign_key: 'qiita_user_id'
end
