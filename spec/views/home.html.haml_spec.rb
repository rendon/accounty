require 'rails_helper'

RSpec.describe 'static_pages/home.html.haml', type: :view do
  before(:each) { render }

  it 'should display welcome message' do
    expect(rendered).to have_selector('h1', text: 'Welcome to Accounty')
  end

  it 'should display sign up link' do
    expect(rendered).to have_selector('a', text: 'Sign Up')
  end
end
