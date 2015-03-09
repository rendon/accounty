require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'Static layout' do
    context 'when user is not logged in' do
      it 'displays section links' do
        visit root_path
        expect(page).to have_title('Accounty')
        expect(find_link('Accounty')[:href]).to be == root_path
        expect(find_link('Help')[:href]).to be == help_path
        expect(find_link('About')[:href]).to be == about_path
        expect(find_link('Sign Up')[:href]).to be == signup_path
      end

      it 'displays home title' do
        visit root_path
        expect(page).to have_title('Accounty')
      end

      it 'displays help title' do
        visit help_path
        expect(page).to have_title('Help | Accounty')
      end

      it 'displays about title' do
        visit about_path
        expect(page).to have_title('About | Accounty')
      end

      it 'displays login link' do
        visit root_path
        expect(find_link('Log in')[:href]).to be == login_path
      end
    end

    context 'when user is logged in' do
      it 'displays profile page link' do
        user = create(:user)
        login_as(user)
        get root_path
        expect(response.body).to include('Profile')
      end
    end
  end
end
