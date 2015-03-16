require 'rails_helper'
RSpec.describe AccountsController, type: :controller do
  context 'when the user is not logged in' do
    describe 'GET #index' do
      it 'redirects to the login page' do
        get :index, user_id: 1, company_id: 1
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to be == MESSAGES[:auth_error]
      end
    end

    describe 'GET #new' do
      it 'redirects to the login page' do
        get :new, user_id: 1, company_id: 1
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to be == MESSAGES[:auth_error]
      end
    end
    
    describe 'POST #create' do
      it 'redirects to the login page' do
        post :create, user_id: 1, company_id: 1, account: {}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to be == MESSAGES[:auth_error]
      end
    end

    describe 'POST #show' do
      it 'redirects to the login page' do
        get :show, user_id: 1, company_id: 1, id: 1
        expect(response).to redirect_to login_path
      end
    end
  end

  context 'when the user is logged in' do
    before(:each) do
      @user = create(:user)
      @company = @user.companies.create(attributes_for(:company))
      login_as(@user)
    end

    describe 'GET #index' do
      context 'when company does not exist' do
        it 'redirects to the dashboard' do
          get :index, user_id: @user.id, company_id: 12345
          expect(response).to redirect_to(user_companies_path(@user))
          expect(flash[:info]).to be == MESSAGES[:not_found]
        end
      end

      context 'when company exist' do
        it 'returns HTTP success' do
          get :index, user_id: @user.id, company_id: @company.id
          expect(response).to have_http_status(:success)
        end
      end

      context "when accessing someone else's company" do
        it 'redirects to the dashboard' do
          get :index, user_id: 12345, company_id: 2
          expect(response).to redirect_to(user_companies_path(@user))
          expect(flash[:danger]).to be == MESSAGES[:auth_error]
        end
      end
    end

    describe 'POST #create' do
      context 'with a valid account' do
        it 'increases User.count by 1' do
          account = attributes_for(:account)
          expect {
            post :create, { user_id: @user.id,
                            company_id: @company.id,
                            account: account }
          }.to change{ Account.count }.by(1)
        end
      end

      context 'with an invalid account' do
        it 'renders new form with error' do
          account = attributes_for(:account, name: '')
          post :create, user_id: @user.id, company_id: @company.id, account: account
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #show' do
      it 'renders show template' do
        account = @company.accounts.create(attributes_for(:account))
        get :show, user_id: @user.id, company_id: @company.id, id: account.id
        expect(response).to render_template(:show)
      end
    end
  end
end
