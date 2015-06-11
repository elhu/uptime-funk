require 'rails_helper'

describe ReportFetcher do
  let(:operator) { create(:operator) }
  let(:facade) { double('facade') }
  let(:params) { facade }
  let(:fetcher) { ReportFetcher.new(params) }

  before do
    allow(facade).to receive(:fetch_report) { {'foo' => 'bar'} }
  end

  describe '#fetch_and_store_report!' do
    before { operator.configure }

    context 'success' do
      it 'stores a new record' do
        expect {
          fetcher.fetch_and_store_report!
        }.to change(WeatherReport.where(operator: operator), :count).by(1)
      end
    end

    context 'failures' do
      before { @previous_count = WeatherReport.where(operator: operator).count }

      it 'raises an error if the HTTP call doesn\'t return 200' do
        allow(facade).to receive(:fetch_report).and_raise FacadeError::BaseError
        expect {
          fetcher.fetch_and_store_report!
        }.to raise_error
        expect(WeatherReport.where(operator: operator).count).to eq(@previous_count)
      end

      it 'raises an error if the operator is not configured' do
        Operator.unconfigure
        expect {
          fetcher.fetch_and_store_report!
        }.to raise_error
        expect(WeatherReport.where(operator: operator).count).to eq(@previous_count)
      end
    end

  end
end