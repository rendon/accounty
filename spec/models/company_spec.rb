require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#name' do
    it 'requires a name' do
      company = build(:company_with_user, name: '')
      expect(company).not_to be_valid
    end
  end

  describe '#user_id' do
    it 'requires a user id' do
      company = build(:company)
      expect(company).not_to be_valid
    end
  end

  describe '#description' do
    it 'should be present' do
      company = build(:company, user_id: 1, description: '')
      expect(company).not_to be_valid
    end

    it 'should be <= 1024 characters' do
      company = build(:company, user_id: 1, description: 'a' * 1025)
      expect(company).not_to be_valid
    end
  end
end
