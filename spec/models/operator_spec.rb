require 'rails_helper'

RSpec.describe Operator, type: :model do
  # Just making sure validations don't get removed accidentally
  describe 'validations' do
    it 'is valid with full arguments' do
      operator = build(:operator)
      expect(operator).to be_valid
    end

    describe 'name' do
      it 'is invalid if missing' do
        operator = build(:operator, name: nil)
        expect(operator).to_not be_valid
      end

      it 'enforces uniqueness' do
        operator = create(:operator)
        other_operator = build(:operator, name: operator.name)
        expect(other_operator).to_not be_valid
      end
    end

    describe 'report_url' do
      it 'is invalid if missing' do
        operator = build(:operator, report_url: nil)
        expect(operator).to_not be_valid
      end

      it 'is invalid if not a valid url' do
        operator = build(:operator, report_url: 'foobar')
        expect(operator).to_not be_valid
      end
    end

    it 'is invalid without city' do
      operator = build(:operator, city: nil)
      expect(operator).to_not be_valid
    end

    it 'is invalid without content_type' do
      operator = build(:operator, content_type: nil)
      expect(operator).to_not be_valid
    end
  end
end
