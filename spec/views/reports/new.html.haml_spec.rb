require 'rails_helper'
RSpec.describe 'reports/new.html.haml', type: :view do
  describe 'layout' do
    before(:each) do
      @user = create(:user)
      assign(:user, @user)
      @company = @user.companies.create(attributes_for(:company))
      assign(:company, @company)
    end

    it 'displays title' do
      render
      expect(rendered).to have_selector('h1', text: 'Reports')
    end

    it 'displays report form' do
      render
      expect(rendered).to have_css('input#start_date')
      expect(rendered).to have_css('input#end_date')
      expect(rendered).to have_css('input.btn')
    end
  end
end
