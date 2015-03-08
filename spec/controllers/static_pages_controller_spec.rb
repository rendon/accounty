require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #home' do
    it 'returns HTTP success' do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #help' do
    it 'returns HTTP success' do
      get :help
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #about' do
    it 'returns HTTP success' do
      get :about
      expect(response).to have_http_status(:success)
    end
  end
end
