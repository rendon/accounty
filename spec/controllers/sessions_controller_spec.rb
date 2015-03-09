require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns HTTP success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with invalid password' do
      it 'renders the login page with error' do
        user = create(:user)
        session = { email: user.email, password: user.password + 'x' }
        post :create, session: session
        expect(response).to render_template(:new)
        expect(flash[:danger]).not_to be_empty
      end
    end

    context 'with invalid email' do
      it 'renders the login page with error' do
        user = create(:user)
        session = { email: 'john_doeATexample.com', password: user.password }
        post :create, session: session
        expect(response).to render_template(:new)
        expect(flash[:danger]).not_to be_blank
      end
    end

    context 'with valid email and password' do
      it 'redirects to user profile page' do
        user = create(:user)
        post :create, session: { email: user.email, password: user.password }
        expect(response).to redirect_to(user_path(user))
        expect(flash[:success]).not_to be_blank
      end
    end
  end
end
