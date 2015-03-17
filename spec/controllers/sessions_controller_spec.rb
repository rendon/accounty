require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    context 'when the user is not logged in' do
      it 'returns HTTP success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the user is logged in' do
      it 'redirects to the profile page' do
        user = create(:user)
        login_as(user)
        get :new
        expect(response).to redirect_to(user_path(user))
      end
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
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).not_to be_blank
      end

      it 'redirect to the previous path after login' do
        user = create(:user)
        session[:previous_url] = user_path(user)
        post :create, session: { email: user.email, password: user.password }
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys session' do
      user = create(:user)
      login_as(user)
      expect(session[:user_id]).not_to be_nil

      delete :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
