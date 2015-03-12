require 'rails_helper'
RSpec.describe 'accounts/new.html.haml', type: :view do
  describe 'new form' do
    it 'renders new account form' do
      user = create(:user)
      assign(:user, user)
      company = user.companies.create(attributes_for(:company))
      assign(:company, company)
      account = company.accounts.new
      assign(:account, account)
      render

      expect(rendered).to have_selector('h1', 'Add account')

      expect(rendered).to have_selector('label', text: 'Name')
      expect(rendered).to have_css('input#account_name')

      expect(rendered).to have_selector('label', text: 'Description')
      expect(rendered).to have_css('textarea#account_description')

      expect(rendered).to have_selector('label', text: 'Category')
      expect(rendered).to have_css('select#account_category')

      expect(rendered).to have_selector('label', text: 'Subcategory')
      expect(rendered).to have_css('select#account_subcategory')

      expect(rendered).to have_css('input.btn')
    end
  end

  describe 'form with invalid data' do
    it 'displays error messages' do
      user = create(:user)
      assign(:user, user)
      company = user.companies.create(attributes_for(:company))
      assign(:company, company)
      account = company.accounts.build(attributes_for(:account, name: ''))
      assign(:account, account)
      account.save
      render
      expect(rendered).to have_css('div.error-explanation')
    end
  end
end
