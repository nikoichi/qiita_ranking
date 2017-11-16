# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :qiita_tags, through: :tag_qiita_tags
end
