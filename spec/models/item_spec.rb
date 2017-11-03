require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'scope' do
    describe 'search_by_qiita_tag_ids' do
      subject { Item.search_by_qiita_tag_ids(qiita_tag_ids) }
      let!(:item_qiita_tag) { create(:item_qiita_tag, item_id: item.id, qiita_tag_id: qiita_tag.id) }
      let(:item) { create(:item) }
      let(:qiita_tag) { create(:qiita_tag, id: 1) }
      context 'qiita_tag_ids検索で一致する場合' do
        let(:qiita_tag_ids) { [1, 2] }
        it { is_expected.to include(item) }
      end
      context 'qiita_tag_ids検索で一致しない場合' do
        let(:qiita_tag_ids) { [2, 3] }
        it { is_expected.to eq [] }
      end
      context 'qiita_tag_idsがnilの場合' do
        let(:qiita_tag_ids) { nil }
        it { is_expected.to include(item) }
      end
    end

    describe 'search_by_year' do
      subject { Item.search_by_year(year) }
      let!(:item) { create(:item, qiita_created_at: '2017-06-01 00:00:00') }
      context 'year検索で一致する場合' do
        let(:year) { Time.zone.local(2017, 1, 1) }
        it { is_expected.to include(item) }
      end
      context 'year検索で一致しない場合' do
        let(:year) { Time.zone.local(2018, 1, 1) }
        it { is_expected.to eq [] }
      end
      context 'yearがnilの場合' do
        let(:year) { nil }
        it { is_expected.to include(item) }
      end
    end
  end
end
