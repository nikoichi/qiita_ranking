# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many :category_tags }
  it { is_expected.to have_many(:tags).through(:category_tags) }
end
