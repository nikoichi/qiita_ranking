require 'rails_helper'

RSpec.describe ItemQiitaTag, type: :model do
  it { is_expected.to belong_to :item }
  it { is_expected.to belong_to :qiita_tag }
end
