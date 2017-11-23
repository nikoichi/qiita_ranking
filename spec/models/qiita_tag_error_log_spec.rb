require 'rails_helper'

RSpec.describe QiitaTagErrorLog, type: :model do
  it { is_expected.to belong_to :qiita_tag }
end
