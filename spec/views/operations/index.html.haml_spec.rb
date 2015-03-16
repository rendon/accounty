require 'rails_helper'
RSpec.describe 'operations/index.html.haml', type: :view do
  before(:each) do
    @user = create(:user)
    assign(:user, @user)
    @company = @user.companies.create(attributes_for(:company))
    assign(:company, @company)
    @company.operations.create(description: 'Buy apples')
    @company.operations.create(description: 'Sell car')
    @operations = @company.operations
    assign(:operations, @operations)
  end

  describe 'layout' do
    before(:each) { render }

    it 'displays title' do
      expect(rendered).to have_content('Operations')
    end
    
    it 'displays "Add operation" option' do
      expect(rendered).to have_selector('a', text: 'Add operation')
    end
  end

  describe 'displays operations' do
    it "displays operations' descriptions" do
      render
      @operations.each do |operation|
        expect(rendered).to have_selector('a', text: operation.description)
      end
    end
  end
end
