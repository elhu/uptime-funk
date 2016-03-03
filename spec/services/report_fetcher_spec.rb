require 'rails_helper'

describe ReportFetcher do
  let(:operator) { create(:operator) }
  let(:facade) { double('facade') }
  let(:processor_klass) { Ratp::OutageProcessor }
  let(:params) { [facade, processor_klass] }
  let(:fetcher) { ReportFetcher.new(*params) }

  before do
    allow(facade).to receive(:fetch_report) { {'foo' => 'bar'} }
    allow_any_instance_of(processor_klass).to receive(:process)
  end

  describe '#fetch_and_store_report!' do
    before { operator.configure }

    context 'success' do
      it 'stores a new record' do
        expect {
          fetcher.fetch_and_store_report!
        }.to change(Report.where(operator: operator), :count).by(1)
      end
    end

    context 'failures' do
      before { @previous_count = Report.where(operator: operator).count }

      it 'raises an error if the HTTP call doesn\'t return 200' do
        allow(facade).to receive(:fetch_report).and_raise FacadeError::BaseError
        expect {
          fetcher.fetch_and_store_report!
        }.to raise_error
        expect(Report.where(operator: operator).count).to eq(@previous_count)
      end

      it 'raises an error if the operator is not configured' do
        Operator.unconfigure
        expect {
          fetcher.fetch_and_store_report!
        }.to raise_error
        expect(Report.where(operator: operator).count).to eq(@previous_count)
      end
    end

  end
end
