require 'rails_helper'
RSpec.describe 'operations/show.html.haml', type: :view do
  describe 'layout' do
    it 'displays operation description' do
      operation = build_stubbed(:operation)
      assign(:operation, operation)
      render
      expect(rendered).to have_content(operation.description)
    end
  end
end
