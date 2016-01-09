require 'rails_helper'

RSpec.describe Outage, type: :model do
  describe 'validations' do
    it 'is valid with full list of arguments' do
      expect(build(:outage)).to be_valid
    end

    it 'is not valid with line missing' do
      expect(build(:outage, line: nil)).not_to be_valid
    end

    it 'is not valid with outage_type missing' do
      expect(build(:outage, outage_type: nil)).not_to be_valid
    end
  end

  describe '#set_started_at' do
    it 'is called upon creation' do
      outage = build(:outage)
      expect(outage).to receive(:set_started_at)
      outage.save
    end

    it 'defaults to the current time' do
      outage = create(:outage)
      expect(outage.started_at).to be_within(1.second).of(Time.now)
    end

    it 'does not override manually set values' do
      past_date = 1.year.ago
      outage = create(:outage, boundaries: past_date..(Time.now))
      expect(outage.started_at).to eq(past_date)
    end
  end

  describe '#close!' do
    let(:outage) { create(:outage) }

    it 'sets finished_at to now by default' do
      outage.close!
      expect(outage.finished_at).to be_within(1.second).of(Time.now)
    end

    it 'allows setting a custom finished_at' do
      outage.close!(1.year.from_now)
      expect(outage.finished_at).to be_within(1.second).of(1.year.from_now)
    end

    it 'computes a duration in seconds' do
      outage.close!(1.day.from_now)
      expect(outage.duration).to be_within(1).of(1.day)
    end
  end

end
