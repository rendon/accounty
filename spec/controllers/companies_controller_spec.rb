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
        it 'renders new template' do
          company = attributes_for(:company, name: '')
          post :create, user_id: @user, company: company
          expect(response).to render_template(:new)
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
        @user.companies.create(attributes_for(:company, name: 'Company X'))
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
        it 'redirects to the home page' do
          get :show, user_id: 12345, id: @company.id
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  context 'when the user is not logged in' do
    describe 'GET #new' do
      it 'redirects to home page' do
        get :new, user_id: 1
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to home page' do
        user = create(:user)
        company = attributes_for(:company)
        post :create, user_id: user.id, company: company
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET #index' do
      it 'rediects to the home page' do
        user = create(:user)
        get :index, user_id: user.id
        expect(response).to redirect_to root_path
        expect(flash[:danger]).to match /You're not authorized/
      end
    end

    describe 'GET #show' do
      it 'redirects to the home page' do
        get :show, user_id: 1, id: 1
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to match /You're not authorized/
      end
    end
  end
end
