class QiitaTag < ApplicationRecord
  has_many :items, through: :item_qiita_tags
end
