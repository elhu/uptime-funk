require 'uri'
require 'net/http'

class ReportFetcher
  attr_accessor :facade, :processor_klass

  def initialize(facade, processor_klass)
    self.facade = facade
    self.processor_klass = processor_klass
  end

  def fetch_and_store_report!
    report = store_report(facade.fetch_report)
    processor_klass.new(report).process
  end

  private
  def store_report(report)
    WeatherReport.create!(report: report)
  end
end
