require 'rails_helper'

RSpec.describe Operation, type: :model do
  describe '#description' do
    it 'should be present' do
      expect(build(:operation, description: '')).not_to be_valid
    end

    it 'should be less than 1024 characters' do
      expect(build(:operation, description: 'a' * 1025)).not_to be_valid
    end

    it { expect(build(:operation, description: 'a')).to be_valid }
  end
end
