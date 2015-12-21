require 'rails_helper'

describe Ratp::OutageProcessor do
  before do
    @operator = create(:operator)
    @operator.configure
  end

  describe '#process' do
    context 'with an ongoing outage' do
      before do
        @outage = create(:outage, operator: @operator, started_at: 1.day.ago, line: 'RER B', outage_type: 'Trafic perturbé')
      end

      it 'does nothing of the outage is still ongoing' do
        processor = Ratp::OutageProcessor.new(create(:full_report_with_outage, operator: @operator))
        expect(@outage.finished_at).to be_nil
        expect {
          processor.process
        }.not_to change(@outage, :finished_at)
      end

      it 'closes the outage is if it is over' do
        processor = Ratp::OutageProcessor.new(create(:full_report_without_outage, operator: @operator))
        expect(@outage.finished_at).to be_nil
        expect {
          processor.process
        }.to change { @outage.reload.finished_at }
      end

      it 'uses the time returned from the API to close the outage' do
        report = create(:full_report_without_outage, operator: @operator)
        allow(report).to receive(:api_time).and_return(1.hour.ago)
        processor = Ratp::OutageProcessor.new(report)
        expect(@outage.finished_at).to be_nil
        expect {
          processor.process
        }.to change { @outage.reload.finished_at }.to within(1).of(1.hour.ago)
      end
    end

    context 'with no ongoing outage' do
      it 'does nothing if there is no outage' do
        processor = Ratp::OutageProcessor.new(create(:full_report_without_outage, operator: @operator))
        expect {
          processor.process
        }.to_not change(Outage, :count)
      end

      it 'creates an outage if an new outage has been announced' do
        processor = Ratp::OutageProcessor.new(create(:full_report_with_outage, operator: @operator))
        expect {
          processor.process
        }.to change(Outage, :count).by(2)
      end

      it 'uses the time returned from the API to open the outage' do
        report = create(:full_report_with_outage, operator: @operator)
        allow(report).to receive(:api_time).and_return(1.hour.ago)
        processor = Ratp::OutageProcessor.new(report)
        processor.process
        expect(Outage.last.started_at).to be_within(1).of(1.hour.ago)
      end

      it 'sets the correct line and outage_type' do
        processor = Ratp::OutageProcessor.new(create(:full_report_with_outage, operator: @operator))
        processor.process
        outage = Outage.last
        expect(outage.line).to eq('RER B')
        expect(outage.outage_type).to eq('Trafic perturbé')
      end
    end
  end
end
