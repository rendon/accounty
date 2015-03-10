require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #home' do
    it 'returns HTTP success' do
      get :home
      expect(response).to have_http_status(:success)
    end

    context 'when the user is not logged in' do
      it 'renders home template' do
        get :home
        expect(response).to render_template(:home)
      end
    end

    context 'when the user is logged in' do
      it 'renders dashboard template' do
        user = create(:user)
        login_as(user)
        get :home
        expect(response).to render_template(:dashboard)
      end
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
