require 'rails_helper'
RSpec.describe 'companies/show.html.haml', type: :view do
  it 'renders company details' do
    company = build_stubbed(:company_with_user)
    assign(:company, company)
    render
    expect(rendered).to have_selector('h1', text: company.name)
    expect(rendered).to have_content(company.description)
    expect(rendered).to have_selector('img')
  end
end
