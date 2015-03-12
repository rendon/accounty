require 'rails_helper'
RSpec.describe 'accounts/index.html.haml', type: :view do
  describe 'layout' do
    before(:each) do
      user = create(:user)
      assign(:user, user)
      company = user.companies.create(attributes_for(:company))
      assign(:company, company)
      assign(:accounts, company.accounts)
    end

    it 'displays title' do
      render
      expect(rendered).to have_selector('h1', text: 'Accounts')
    end

    it 'displays "Add account" link' do
      render
      expect(rendered).to have_selector('a', text: 'Add account')
    end
  end

  describe 'display accounts' do
    it 'displays all the accounts' do
      user = create(:user)
      assign(:user, user)
      company = user.companies.create(attributes_for(:company))
      assign(:company, company)
      company.accounts.create(attributes_for(:account, name: 'Cash'))
      company.accounts.create(attributes_for(:account, name: 'Inventory'))
      company.accounts.create(attributes_for(:account, name: 'Supplies'))
      assign(:accounts, company.accounts)
      render
      company.accounts.each do |account|
        expect(rendered).to have_content(account.name)
        expect(rendered).to have_content(account.description)
        expect(rendered).to have_content(account.category.camelize)
        expect(rendered).to have_content(account.subcategory.camelize)
      end
    end
  end
end
