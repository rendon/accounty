require 'rails_helper'

RSpec.describe 'static_pages/about.html.haml', type: :view do
  before(:each) { render }

  it 'displays information about Accounty' do
    expect(rendered).to have_selector('h1', text: 'About Accounty')
  end
end
