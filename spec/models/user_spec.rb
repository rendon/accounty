require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'new user' do
    it 'should be valid' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'should not be valid for invalid email' do
      user = build(:user, email: 'johndoemail.com')
      expect(user).not_to be_valid
    end
  end

  describe 'email is not case sensitive' do
    it 'john@mail.com and JOHN@mail.com are the same' do
      little_john = create(:user, email: 'john@mail.com')
      big_john = build(:user, email: 'JOHN@mail.com')
      expect(big_john).not_to be_valid
    end
  end

  describe '#full_name' do
    it 'returns the full name' do
      user = create(:user)
      expect(user.full_name).to be == "#{user.name} #{user.last_name}"
    end
  end
end
