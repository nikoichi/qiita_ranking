require 'rails_helper'

RSpec.describe RankingController, type: :controller do
  describe 'GET index' do
    it 'indexを表示すること' do
      get :index
      expect(response).to render_template :index
    end
  end
end
