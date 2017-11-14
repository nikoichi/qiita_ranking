# frozen_string_literal: true

class QiitaUserStock < ApplicationRecord
  belongs_to :qiita_user
  belongs_to :item
end
