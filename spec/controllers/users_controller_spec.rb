require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns HTTP success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns user' do
      get :new
      expect(assigns(:user)).not_to be_nil
    end
  end

  describe 'POST #create' do
    context 'when user is valid' do
      it 'redirects to the home page' do
        user = attributes_for(:user)
        post :create, user: user
        expect(response).to redirect_to root_path
      end
    end

    context 'when the user is invalid' do
      it 'fails when name is blank' do
        post :create, user: attributes_for(:user, name: '')
        expect(response).to render_template(:new)
      end

      it 'fails when last name is blank' do
        post :create, user: attributes_for(:user, last_name: '')
        expect(response).to render_template(:new)
      end

      it 'fails when email is malformed' do
        post :create, user: attributes_for(:user, email: 'rafaATgmail.com')
        expect(response).to render_template(:new)
      end

      it 'fails when password is blank' do
        post :create, user: attributes_for(:user, password: '')
        expect(response).to render_template(:new)
      end

      it 'fails when password is too short' do
        user =  attributes_for(:user, password: 'aaaaaaa',
                               password_confirmation: 'aaaaaaa')
        post :create, user: user
        expect(response).to render_template(:new)
      end
      
      it 'fails when password and password confirmation do not match' do
        user =  attributes_for(:user, password: 'aaaaaaaa',
                               password_confirmation: 'bbbbbbbb')
        post :create, user: user
        expect(response).to render_template(:new)
      end
    end
  end
end
