# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemErrorLog, type: :model do
  it { is_expected.to belong_to :item }
end
