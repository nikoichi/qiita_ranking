# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_tags, dependent: :delete_all
  has_many :tags, through: :category_tags
end
