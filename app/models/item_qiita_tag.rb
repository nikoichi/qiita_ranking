class ItemQiitaTag < ApplicationRecord
  belongs_to :item
  belongs_to :qiita_tag
end
