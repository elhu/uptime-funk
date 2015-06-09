require 'rails_helper'

describe ReportFetcher do
  describe '#fetch_and_store_report!' do
    context 'success' do
      it 'stores a new record' do
        pending 'to implement'
        fail
      end
    end

    context 'failures' do
      it 'raises an error if the HTTP call doesn\'t return 200' do
        pending 'to implement'
        fail
      end

      it 'raises an error if it get an un-parsable output' do
        pending 'to implement'
        fail
      end
    end
  end
end
