# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :qiita_tags, through: :tag_qiita_tags
  has_many :categories, through: :category_tags
  has_many :category_tags, dependent: :delete_all
end
