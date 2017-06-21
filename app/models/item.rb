class Item < ApplicationRecord
  belongs_to :qiita_user
  has_many :qiita_tags, through: :item_qiita_tags
end
