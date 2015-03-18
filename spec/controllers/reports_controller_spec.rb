require 'rails_helper'
RSpec.describe ReportsController, type: :controller do
  context 'when the user is not logged in' do
    describe 'GET #new' do
      it 'redirects to the login page' do
        get :new, user_id: 1, company_id: 1
        expect(response).to redirect_to(login_path)
      end
    end
  end

  context 'when the user is logged in' do
    before(:each) do
      @user = create(:user)
      @company = @user.companies.create(attributes_for(:company))
      login_as(@user)
    end

    describe 'GET #new' do
      it 'returns HTTP success' do
        get :new, user_id: @user.id, company_id: @company.id
        expect(response).to have_http_status(:success)
      end

      it 'assigns user' do
        get :new, user_id: @user.id, company_id: @company.id
        expect(assigns(:user).id).to be == @user.id
      end

      it 'assigns company' do
        get :new, user_id: @user.id, company_id: @company.id
        expect(assigns(:company).id).to be == @company.id
      end
    end
  end
end
