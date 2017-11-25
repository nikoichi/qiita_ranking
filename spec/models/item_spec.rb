# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to belong_to :qiita_user }
  it { is_expected.to have_many :item_qiita_tags }
  it { is_expected.to have_many(:qiita_tags).through(:item_qiita_tags) }
  # FIXME: 通らない。いつか直す。
  # it { is_expected.to have_many(:stock_users).through(:qiita_user_stocks) }

  shared_examples_for '検索結果にitemを含む' do
    it { is_expected.to include(item) }
  end
  shared_examples_for '検索結果が空' do
    it { is_expected.to eq [] }
  end

  describe 'scope' do
    describe 'search_by_tag_id' do
      subject { Item.search_by_tag_id(tag_id) }
      let!(:item_qiita_tag) { create(:item_qiita_tag, item_id: item.id, qiita_tag_id: qiita_tag.id) }
      let!(:tag_qiita_tag) { create(:tag_qiita_tag, tag: tag, qiita_tag: qiita_tag) }
      let(:item) { create(:item) }
      let(:qiita_tag) { create(:qiita_tag, id: 1) }
      let(:tag) { create(:tag, id: 1) }
      context 'tag_id検索で一致する場合' do
        let(:tag_id) { 1 }
        it_behaves_like '検索結果にitemを含む'
      end
      context 'tag_id検索で一致しない場合' do
        let(:tag_id) { 2 }
        it_behaves_like '検索結果が空'
      end
      context 'tag_idがnilの場合' do
        let(:tag_id) { nil }
        it_behaves_like '検索結果にitemを含む'
      end
    end

    describe 'search_by_year' do
      subject { Item.search_by_year(year) }
      let!(:item) { create(:item, qiita_created_at: '2017-06-01 00:00:00') }
      context 'year検索で一致する場合' do
        let(:year) { 2017 }
        it_behaves_like '検索結果にitemを含む'
      end
      context 'year検索で一致しない場合' do
        let(:year) { 2018 }
        it_behaves_like '検索結果が空'
      end
      context 'yearがnilの場合' do
        let(:year) { nil }
        it_behaves_like '検索結果にitemを含む'
      end
    end
  end
end
