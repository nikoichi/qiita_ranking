# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QiitaUserErrorLog, type: :model do
  it { is_expected.to belong_to :qiita_user }
end
