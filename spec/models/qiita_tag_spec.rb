require 'rails_helper'

RSpec.describe QiitaTag, type: :model do
  it { is_expected.to have_many :item_qiita_tags }
  it { is_expected.to have_many(:items).through(:item_qiita_tags) }
  it { is_expected.to have_many(:tags).through(:tag_qiita_tags) }
  it { is_expected.to have_many :tag_qiita_tags }
end
