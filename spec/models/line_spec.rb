require 'rails_helper'

RSpec.describe Line, type: :model do
  before do
    @operator = create(:operator)
    @operator.configure
  end

  describe 'validations' do
    it 'is valid when provided with the full list of arguments' do
      expect(build(:line)).to be_valid
    end
    it 'requires an operator label (used when fetching reports)' do
      expect(build(:line, operator_label: nil)).not_to be_valid
    end
  end
end
