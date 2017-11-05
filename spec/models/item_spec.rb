require 'rails_helper'

RSpec.describe Item, type: :model do
  shared_examples_for '検索結果にitemを含む' do
    it { is_expected.to include(item) }
  end
  shared_examples_for '検索結果が空' do
    it { is_expected.to eq [] }
  end

  describe 'scope' do
    describe 'search_by_qiita_tag_ids' do
      subject { Item.search_by_qiita_tag_ids(qiita_tag_ids) }
      let!(:item_qiita_tag) { create(:item_qiita_tag, item_id: item.id, qiita_tag_id: qiita_tag.id) }
      let(:item) { create(:item) }
      let(:qiita_tag) { create(:qiita_tag, id: 1) }
      context 'qiita_tag_ids検索で一致する場合' do
        let(:qiita_tag_ids) { [1, 2] }
        it_behaves_like '検索結果にitemを含む'
      end
      context 'qiita_tag_ids検索で一致しない場合' do
        let(:qiita_tag_ids) { [2, 3] }
        it_behaves_like '検索結果が空'
      end
      context 'qiita_tag_idsがnilの場合' do
        let(:qiita_tag_ids) { nil }
        it_behaves_like '検索結果にitemを含む'
      end
    end

    describe 'search_by_year' do
      subject { Item.search_by_year(year) }
      let!(:item) { create(:item, qiita_created_at: '2017-06-01 00:00:00') }
      context 'year検索で一致する場合' do
        let(:year) { Time.zone.local(2017, 1, 1) }
        it_behaves_like '検索結果にitemを含む'
      end
      context 'year検索で一致しない場合' do
        let(:year) { Time.zone.local(2018, 1, 1) }
        it_behaves_like '検索結果が空'
      end
      context 'yearがnilの場合' do
        let(:year) { nil }
        it_behaves_like '検索結果にitemを含む'
      end
    end
  end
end
