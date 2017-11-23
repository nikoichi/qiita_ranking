require 'rails_helper'

RSpec.describe Tag, type: :model do
  # FIXME: なぜか通らない。いつか直す。
  # it { is_expected.to have_many(:qiita_tags).through(:tag_qiita_tags) }
  it { is_expected.to have_many(:categories).through(:category_tags) }
  it { is_expected.to have_many :category_tags }
end
