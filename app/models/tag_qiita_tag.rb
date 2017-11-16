# frozen_string_literal: true

class TagQiitaTag < ApplicationRecord
  belongs_to :tag
  belongs_to :qiita_tag
end
