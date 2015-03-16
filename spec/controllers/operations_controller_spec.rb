require 'rails_helper'
RSpec.describe OperationsController, type: :controller do
  context 'when the user not logged in' do
    describe 'GET #new' do
      it 'redirects to the login page' do
        get :new, user_id: 1, company_id: 1
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'GET #index' do
      it 'redirects to the login page' do
        get :index, user_id: 1, company_id: 1
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to the login page' do
        operation = attributes_for(:operation)
        post :create, user_id: 1, company_id: 1, operation: operation
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'GET #show' do
      it 'redirects to the login page' do
        get :show, user_id: 1, company_id: 1, id: 1
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
      before(:each) { get :new, user_id: @user.id, company_id: @company.id }
      it 'returns HTTP success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns the correct user' do
        expect(assigns(:user).id).to be == @user.id
      end

      it 'assigns the correct company' do
        expect(assigns(:company).id).to be == @company.id
      end

      it 'assigns @operation' do
        expect(assigns(:operation)).not_to be_nil
      end
    end

    describe 'GET #index' do
      before(:each) { get :index, user_id: @user.id, company_id: @company.id }
      it 'returns HTTP success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns @operations' do
        expect(assigns(:operations)).not_to be_nil
      end

      it 'assigns the corrects operations' do
        expect(assigns(:operations)).to be == @company.operations
      end
    end

    describe 'POST #create' do
      context 'create valid operation' do
        it 'changes Operation.count by 1' do
          expect do
            post :create, user_id: @user.id,
                          company_id: @company.id,
                          operation: attributes_for(:operation)
          end.to change { Operation.count }.by(1)
        end

        it 'redirect to the new operation page' do
          post :create, user_id: @user.id,
                        company_id: @company.id,
                        operation: attributes_for(:operation)
          id = Operation.order(:created_at).last.id
          args = { user_id: @user.id, company_id: @company.id, id: id }
          expect(response).to redirect_to(user_company_operation_path(args))
          expect(flash[:success]).not_to be_nil
        end
      end

      context 'create invalid operation' do
        it 'renders the form with errors' do
          post :create, user_id: @user.id,
                        company_id: @company.id,
                        operation: attributes_for(:operation, description: '')
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #show' do
      it 'assigns the right operation' do
        operation = @company.operations.create(attributes_for(:operation))
        get :show, user_id: @user.id, company_id: @company.id, id: operation.id
        expect(assigns(:operation).id).to be == operation.id
        expect(assigns(:operation_detail)).not_to be_nil
      end
    end
  end
end
