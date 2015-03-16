require 'rails_helper'
RSpec.describe 'operations/show.html.haml', type: :view do
  before(:each) do
    @user = create(:user)
    assign(:user, @user)
    @company = @user.companies.create(attributes_for(:company))
    assign(:company, @company)
    @operation = @company.operations.create(description: 'Buy some beer')
    assign(:operation, @operation)
    @operation_detail = @operation.operation_details.new
    assign(:operation_detail, @operation_detail)
    @operation_details = @operation.operation_details
    assign(:operation_details, @operation_details)
  end

  describe 'layout' do
    it 'displays operation description' do
      render
      expect(rendered).to have_content(@operation.description)
      expect(rendered).to have_css('select#operation_detail_account_id')
      expect(rendered).to have_css('input#operation_detail_amount')
      expect(rendered).to have_css('input.btn')
    end
  end

  describe 'operation detail' do
    context 'form with invalid data' do
      it 'displays error messages' do
        @operation_detail.account_id = 0
        @operation_detail.save
        render
        expect(rendered).to have_css('div.error-explanation')
      end
    end

    describe 'display operation details' do
      before(:each) do
        @account = @company.accounts.create(attributes_for(:account, name: 'Cash'))
        @operation.operation_details.create(account_id: @account.id, amount: 50)
        @operation_details = @operation.operation_details
        assign(:operation_details, @operation_details)
      end

      it "displays details' account name" do
        render
        @operation_details.each do |detail|
          account = @company.accounts.find_by(id: detail.account_id)
          next if detail.id.nil?
          expect(rendered).to have_content(account.name, count: 2)
        end
      end

      it "displays details' amount" do
        render
        @operation_details.each do |detail|
          expect(rendered).to have_content(detail.amount)
        end
      end
    end
  end
end
