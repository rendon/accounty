require 'rails_helper'
RSpec.describe 'operations/new.html.haml' do
  describe 'new form' do
    it 'displays the right elements' do
      user = create(:user)
      assign(:user, user)
      company = user.companies.create(attributes_for(:company))
      assign(:company, company)
      operation = company.operations.new
      assign(:operation, operation)
      render
      expect(rendered).to have_content('Add operation')
      expect(rendered).to have_css('textarea#operation_description')
      expect(rendered).to have_css('input.btn')
    end
  end

  describe 'form with invalid data' do
    it 'displays error messages' do
      user = create(:user)
      assign(:user, user)
      company = user.companies.create(attributes_for(:company))
      assign(:company, company)
      attributes = attributes_for(:operation, description: '')
      operation = company.operations.build(attributes)
      operation.save
      assign(:operation, operation)
      render
      expect(rendered).to have_css('div.error-explanation')
    end
  end
end
