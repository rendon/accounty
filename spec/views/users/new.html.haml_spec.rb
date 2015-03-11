require 'rails_helper'
RSpec.describe 'users/new.html.haml' do
  it 'displays new user form' do
    visit new_user_path
    expect(page).to have_selector('label', text: 'Name')
    expect(page).to have_css('input#user_name')

    expect(page).to have_selector('label', text: 'Last name')
    expect(page).to have_css('input#user_last_name')

    expect(page).to have_selector('label', text: 'Email')
    expect(page).to have_css('input#user_email')

    expect(page).to have_selector('label', text: 'Password')
    expect(page).to have_css('input#user_password')

    expect(page).to have_selector('label', text: 'Password confirmation')
    expect(page).to have_css('input#user_password_confirmation')

    expect(page).to have_selector('input.btn')
  end
end
