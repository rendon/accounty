require 'rails_helper'

RSpec.describe 'sessions/new.html.haml', type: :view do
  before(:each) do
    render
  end

  it 'should display form' do
    expect(rendered).to have_selector('label', text: 'Email')
    expect(rendered).to have_css('input#session_email')

    expect(rendered).to have_selector('label', text: 'Password')
    expect(rendered).to have_css('input#session_password')

    expect(rendered).to have_selector('input')
  end
end
