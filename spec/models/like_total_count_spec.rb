require 'rails_helper'

RSpec.describe LikeTotalCount, type: :model do
  it { is_expected.to belong_to :item }
end
