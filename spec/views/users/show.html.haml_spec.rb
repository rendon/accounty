require 'rails_helper'
RSpec.describe 'users/show.html.haml', type: :view do
  it 'displays user information' do
    user = build_stubbed(:user)
    assign(:user, user)
    render
    expect(rendered).to have_content("#{user.name} #{user.last_name}")
    expect(rendered).to have_content("#{user.email}")
    expect(rendered).to have_selector('img')
  end
end
