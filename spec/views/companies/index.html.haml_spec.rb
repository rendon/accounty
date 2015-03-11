require 'rails_helper'
RSpec.describe 'companies/index.html.haml', type: :view do
  it 'displays dashboard' do
    user = create(:user)
    assign(:user, user)
    assign(:companies, user.companies)
    render
    expect(rendered).to have_selector('h1', text: 'My companies')
    expect(rendered).to have_selector('a', text: 'Add company')
  end

  it 'displays companies' do
    user = create(:user)
    user.companies.create(attributes_for(:company, name: 'company x'))
    user.companies.create(attributes_for(:company, name: 'company y'))
    user.save
    assign(:user, user)
    assign(:companies, user.companies)
    render
    user.companies.each do |company|
      expect(rendered).to have_selector('a', text: company.name)
    end
  end
end
