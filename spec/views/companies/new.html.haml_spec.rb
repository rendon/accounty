require 'rails_helper'
RSpec.describe 'companies/new.html.haml', type: :view do
  context 'new form' do
    it 'displays new company form' do
      user = create(:user)
      assign(:user, user)
      assign(:company, user.companies.build)
      render
      expect(rendered).to have_selector('h1', text: 'Add company')

      expect(rendered).to have_selector('label', text: 'Name')
      expect(rendered).to have_css('input#company_name')

      expect(rendered).to have_selector('label', text: 'Description')
      expect(rendered).to have_css('textarea#company_description')

      expect(rendered).to have_selector('label', text: 'Logo')
      expect(rendered).to have_css('input#company_logo')

      expect(rendered).to have_css('input.btn')
    end
  end

  context 'form with invalid data' do
    it 'displays error messages' do
      user = create(:user)
      assign(:user, user)
      company = user.companies.build(name: '')
      assign(:company, company)
      user.save
      render
      expect(rendered).to have_css('div.error-explanation')
    end
  end
end
