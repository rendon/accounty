require 'rails_helper'
RSpec.describe 'companies/show.html.haml', type: :view do
  it 'renders company details' do
    user = build_stubbed(:user)
    assign(:user, user)
    company = build_stubbed(:company_with_user)
    assign(:company, company)
    render
    expect(rendered).to have_selector('h1', text: company.name)
    expect(rendered).to have_content(company.description)
    expect(rendered).to have_selector('img')

    expect(rendered).to have_selector('a', text: 'Accounts')
    expect(rendered).to have_selector('a', text: 'Operations')
    expect(rendered).to have_selector('a', text: 'Reports')
  end
end
