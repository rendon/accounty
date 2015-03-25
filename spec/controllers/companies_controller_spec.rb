require 'rails_helper'
RSpec.describe CompaniesController, type: :controller do
  context 'when the user is logged in' do
    before(:each) do
      @user = create(:user)
      login_as(@user)
    end

    describe 'GET #new' do
      it 'returns HTTP success' do
        get :new, user_id: @user.id
        expect(response).to have_http_status(:success)
      end

      it 'renders new template' do
        get :new, user_id: @user.id
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      context 'invalid form submission' do
        describe 'empty name' do
          it 'renders the :new template' do
            company = attributes_for(:company, name: '')
            post :create, user_id: @user, company: company
            expect(response).to render_template(:new)
          end
        end

        describe 'empty description' do
          it 'assigns @user' do
            company = attributes_for(:company, description: '')
            post :create, user_id: @user, company: company
            expect(assigns(:user)).not_to be_nil
          end

          it 'assigns @company' do
            company = attributes_for(:company, description: '')
            post :create, user_id: @user, company: company
            expect(assigns(:company)).not_to be_nil
          end
        end
      end

      context 'valid form submission' do
        it 'redirects to companies index' do
          company = attributes_for(:company)
          post :create, user_id: @user, company: company
          expect(response).to redirect_to(user_companies_path(@user))
        end
      end
    end

    describe 'GET #index' do
      it 'returns HTTP success' do
        get :index, user_id: @user.id
        expect(response).to have_http_status(:success)
      end

      it 'assigns the list of companies' do
        @user.companies.create(attributes_for(:company, name: 'Company X'))
        @user.companies.create(attributes_for(:company, name: 'Company Y'))
        get :index, user_id: @user.id
        expect(assigns(:companies).count).to be == 2
      end
    end

    describe 'GET #show' do
      before(:each) do
        @company = @user.companies.create(attributes_for(:company))
      end

      it 'returns HTTP success' do
        get :show, user_id: @user.id, id: @company.id
        expect(response).to have_http_status(:success)
      end

      it 'assigns company' do
        get :show, user_id: @user.id, id: @company.id
        expect(assigns(:company).id).to be == @company.id
      end

      context "trying to access someone else's resources" do
        it 'redirects to the dashboard page' do
          get :show, user_id: @user.id, id: 12_345
          expect(response).to redirect_to(user_companies_path(@user))
        end
      end
    end
  end

  context 'when the user is not logged in' do
    describe 'GET #new' do
      it 'redirects to login page' do
        get :new, user_id: 1
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        user = create(:user)
        company = attributes_for(:company)
        post :create, user_id: user.id, company: company
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'GET #index' do
      it 'rediects to the login page' do
        user = create(:user)
        get :index, user_id: user.id
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to be == MESSAGES[:auth_error]
      end
    end

    describe 'GET #show' do
      it 'redirects to the login page' do
        get :show, user_id: 1, id: 1
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to be == MESSAGES[:auth_error]
      end
    end
  end
end
