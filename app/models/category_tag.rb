# frozen_string_literal: true

class CategoryTag < ApplicationRecord
  belongs_to :tag
  belongs_to :category
end
