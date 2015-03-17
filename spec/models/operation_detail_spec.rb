require 'rails_helper'

RSpec.describe OperationDetail, type: :model do
  describe '#amount' do
    it 'should be positive' do
      expect(build(:operation_detail, amount: -5)).not_to be_valid
      expect(build(:operation_detail, amount: 0)).not_to be_valid
      expect(build(:operation_detail, amount: 0.1)).to be_valid
    end
  end

  describe '#account_id' do
    it 'requires :account_id' do
      operation_detail = build(:operation_detail, amount: 1, account_id: nil)
      expect(operation_detail).not_to be_valid
    end
  end

  describe '#operation_id' do
    it 'requires :operation_id' do
      operation_detail = build(:operation_detail, amount: 1, operation_id: nil)
      expect(operation_detail).not_to be_valid
    end
  end
end
