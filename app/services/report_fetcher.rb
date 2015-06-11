require 'uri'
require 'net/http'

class ReportFetcher
  attr_accessor :facade

  def initialize(facade)
    self.facade = facade
  end

  def fetch_and_store_report!
    store_report(facade.fetch_report)
  end

  private
  def store_report(report)
    WeatherReport.create!(report: report)
  end
end
