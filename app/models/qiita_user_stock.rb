class QiitaUserStock < ApplicationRecord
  belongs_to :qiita_user
  belongs_to :item
end
