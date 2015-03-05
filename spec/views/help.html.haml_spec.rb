require 'rails_helper'

RSpec.describe 'static_pages/help.html.haml', type: :view do
  before(:each) { render }

  it 'displays "Help"' do
    expect(rendered).to have_selector('h1', text: 'Help')
  end
end
