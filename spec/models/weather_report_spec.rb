require 'rails_helper'

RSpec.describe WeatherReport, type: :model do

  # Just ensuring validations aren't removed by mistake
  describe 'validations' do
    it 'is valid with full arguments' do
      weather_report = build(:weather_report)
      expect(weather_report).to be_valid
    end

    describe 'report' do
      it 'is invalid if nil' do
        weather_report = build(:weather_report, report: nil)
        expect(weather_report).to_not be_valid
      end

      it 'is invalid if not JSON' do
        weather_report = build(:weather_report, report: 'foobar')
        expect(weather_report).to_not be_valid
      end

      it 'is invalid if empty JSON' do
        weather_report = build(:weather_report, report: {})
        expect(weather_report).to_not be_valid
      end
    end
  end
end
