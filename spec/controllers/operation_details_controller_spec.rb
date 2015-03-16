require 'rails_helper'
RSpec.describe OperationDetailsController, type: :controller do
  context 'when the user is not logged in' do
    describe 'POST #create' do
      it 'redirects to the login page' do
        post :create, user_id: 1, company_id: 1, operation_id: 1, operation_detail: { }
        expect(response).to redirect_to(login_path)
      end
    end
  end

  context 'when the user is logged in' do
    describe 'POST #create' do
      before(:each) do
        @user = create(:user)
        @company = @user.companies.create(attributes_for(:company))
        @account = @company.accounts.create(attributes_for(:account, name: 'Cash'))
        @operation = @company.operations.create(description: 'Buy some beer')
        login_as(@user)
      end

      context 'valid operation detail' do
        it 'increments OperationDetails by 1' do
          expect do
            post :create, user_id: @user.id, company_id: @company.id,
              operation_id: @operation.id,
              operation_detail: { account_id: @account.id, amount: 100.0 }
          end.to change{ OperationDetail.count }.by(1)
        end

        it 'redirects to the operation page' do
          post :create, user_id: @user.id, company_id: @company.id,
            operation_id: @operation.id,
            operation_detail: { account_id: @account.id, amount: 100.0 }
          expect(response).to redirect_to(user_company_operation_path(@user, @company, @operation))
        end
      end
      
      context 'invalid  operation detail' do
        it 'does not change OperationDetail.count' do
          expect do
            post :create, user_id: @user.id, company_id: @company.id,
              operation_id: @operation.id,
              operation_detail: { account_id: @account.id, amount: 0 }
          end.to change{ OperationDetail.count }.by(0)
        end

        it 'renders operations/show template' do
          post :create, user_id: @user.id, company_id: @company.id,
            operation_id: @operation.id,
            operation_detail: { account_id: @account.id, amount: 0 }
          expect(response).to render_template('operations/show')
        end
      end
    end
  end
end
