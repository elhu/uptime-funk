require 'rails_helper'

RSpec.describe Report, type: :model do

  # Just ensuring validations aren't removed by mistake
  describe 'validations' do
    it 'is valid with full arguments' do
      report = build(:report)
      expect(report).to be_valid
    end

    describe 'report' do
      it 'is invalid if nil' do
        report = build(:report, report: nil)
        expect(report).to_not be_valid
      end

      it 'is invalid if not JSON' do
        report = build(:report, report: 'foobar')
        expect(report).to_not be_valid
      end

      it 'is invalid if empty JSON' do
        report = build(:report, report: {})
        expect(report).to_not be_valid
      end
    end
  end
end
