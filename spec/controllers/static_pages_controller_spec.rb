require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views
  describe 'GET #home' do
    it 'return HTTP success' do
      get :home
      expect(response).to have_http_status(:success)
    end

    it 'displays "Accounty" in the title' do
      visit '/'
      expect(page).to have_title('Accounty')
      expect(find_link('Accounty')[:href]).to be == '/'
      expect(find_link('Help')[:href]).to be == '/help'
      expect(find_link('About')[:href]).to be == '/about'
    end
  end

  describe 'GET #help' do
    it 'return HTTP success' do
      get :help
      expect(response).to have_http_status(:success)
    end

    it 'displays "Help" in the title' do
      visit '/help'
      expect(page).to have_title('Help | Accounty')
    end
  end

  describe 'GET #about' do
    it 'return HTTP success' do
      get :about
      expect(response).to have_http_status(:success)
    end

    it 'displays "About" in the title' do
      visit '/about'
      expect(page).to have_title('About | Accounty')
    end
  end
end
