require 'rails_helper'
RSpec.describe 'accounts/show.html.haml', type: :view do
  describe 'display account details' do
    before(:each) do
      @account = build_stubbed(:account)
      assign(:account, @account)
      render
    end

    it 'displays account name' do
      expect(rendered).to have_content(@account.name)
    end

    it 'displays account description' do
      expect(rendered).to have_content(@account.description)
    end

    it 'displays account category' do
      expect(rendered).to have_content(@account.category.camelize)
    end

    it 'displays account subcategory' do
      expect(rendered).to have_content(@account.subcategory.camelize)
    end
  end
end
