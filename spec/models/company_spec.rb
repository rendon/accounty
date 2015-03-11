require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'requires a name' do
    company = build(:company_with_user, name: '')
    expect(company).not_to be_valid
  end

  it 'requires a user id' do
    company = build(:company)
    expect(company).not_to be_valid
  end
end
