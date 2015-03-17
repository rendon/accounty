require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'new user' do
    it 'should be valid' do
      user = User.new(name: 'Rafael',
                      last_name: 'Rendon Pablo',
                      email: 'rafaelrendonpablo@gmail.com',
                      password: '0a1b2c3d4e',
                      password_confirmation: '0a1b2c3d4e')
      expect(user).to be_valid
    end

    it 'should be invalid for invalid email' do
      user = User.new(name: 'Rafael',
                      last_name: 'Rendon Pablo',
                      email: 'rafaelrendonpablogmail.com',
                      password: '0a1b2c3d4e',
                      password_confirmation: '0a1b2c3d4e')
      expect(user).not_to be_valid
    end
  end

  describe '#full_name' do
    it 'returns the full name' do
      user = create(:user)
      expect(user.full_name).to be == "#{user.name} #{user.last_name}"
    end
  end
end
