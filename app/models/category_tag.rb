# frozen_string_literal: true

class CategoryTag < ApplicationRecord
  belongs_to :category
  belongs_to :tag
end
