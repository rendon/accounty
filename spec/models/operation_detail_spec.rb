require 'rails_helper'

RSpec.describe OperationDetail, type: :model do
  describe '.amount' do
    it 'should be positive' do
      expect(build(:operation_detail, amount: -5)).not_to be_valid
      expect(build(:operation_detail, amount: 0)).not_to be_valid
      expect(build(:operation_detail, amount: 0.1)).to be_valid
    end
  end
end
