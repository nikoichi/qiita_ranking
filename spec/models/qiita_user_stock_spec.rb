require 'rails_helper'

RSpec.describe QiitaUserStock, type: :model do
  it { is_expected.to belong_to :qiita_user }
  it { is_expected.to belong_to :item }
end
