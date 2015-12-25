require 'rails_helper'

describe Fetcher do
  let!(:operator) { Operator.where(name: 'RATP').first }
  let(:worker) { Fetcher.new }

  describe '#perform' do
    before do
      stub_request(:get, "http://www.ratp.fr/meteo/ajax/data").to_return(body: '{"foo": "bar"}')
      allow_any_instance_of(Ratp::OutageProcessor).to receive(:process)
    end

    context 'with a valid operator_id' do
      it 'instantiates a ReportFetcher with the correct operator and formatter' do
        expect(ReportFetcher).to receive(:new).and_call_original
        worker.perform(operator.id)
      end

      it 'calls ReportFetch#fetch_and_store!' do
        expect_any_instance_of(ReportFetcher).to receive(:fetch_and_store_report!)
        worker.perform(operator.id)
      end

      it 'creates a new report record for the operator' do
        expect {
          worker.perform(operator.id)
        }.to change(WeatherReport.where(operator: operator), :count).by(1)
      end
    end

    context 'with an invalid operator_id' do
      it 'raises an error' do
        expect {
          worker.perform('foo')
        }.to raise_error
      end
    end
  end
end
