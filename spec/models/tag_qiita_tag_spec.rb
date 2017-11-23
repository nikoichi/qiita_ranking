require 'rails_helper'

RSpec.describe TagQiitaTag, type: :model do
  it { is_expected.to belong_to :tag }
  it { is_expected.to belong_to :qiita_tag }
end
