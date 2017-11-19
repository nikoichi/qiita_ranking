# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_tags
  has_many :tags, through: :category_tags
end
