require 'rails_helper'
RSpec.describe Account, type: :model do
  describe '#name' do
    it 'requires name field' do
      expect(build(:account, name: '')).not_to be_valid
    end

    it 'is invalid if name is too long' do
      expect(build(:account, name: 'a' * 65)).not_to be_valid
    end
  end

  describe '#description' do
    it 'is invlid if description is too long' do
      expect(build(:account, description: 'a' * 1025)).not_to be_valid
    end
  end

  describe '#category' do
    it 'requires category' do
      expect(build(:account, category: '')).not_to be_valid
    end

    describe 'valid values [:assets, :liabilities]' do
        it { expect(build(:account, category: 'Banks')).not_to be_valid   }
        it { expect(build(:account, category: :assets)).to be_valid      }
        it { expect(build(:account, category: :liabilities)).to be_valid }
    end
  end

  describe '#subcategory' do
    it 'requires subcategory' do
      expect(build(:account, subcategory: '')).not_to be_valid
    end

    describe 'valid values [:current, :long_term]' do
      it { expect(build(:account, subcategory: 'Building')).not_to be_valid }
      it { expect(build(:account, subcategory: :current)).to be_valid      }
      it { expect(build(:account, subcategory: :long_term)).to be_valid    }
    end
  end

  describe '#company_id' do
    it 'requires :company_id' do
      expect(build(:account, company_id: nil)).not_to be_valid
    end
  end
end
