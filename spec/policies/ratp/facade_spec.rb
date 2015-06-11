require 'rails_helper'

describe Ratp::Facade do
  it 'raises an error if returning with status other than 200' do
    stub_request(:get, "http://www.ratp.fr/meteo/ajax/data").to_return(status: 500)
    expect {
      described_class.new.fetch_report
    }.to raise_error FacadeError::RemoteHost
  end

  it 'raises an error if returning unparsable output' do
    stub_request(:get, "http://www.ratp.fr/meteo/ajax/data").to_return(status: 200, body: "foobar")
    expect {
      described_class.new.fetch_report
    }.to raise_error FacadeError::UnparseableOutput
  end
end
