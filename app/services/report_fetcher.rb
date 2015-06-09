require 'uri'
require 'net/http'

class ReportFetcher
  attr_accessor :url, :formatter

  def initialize(url:, formatter: ReportFormatter::JSON.new)
    self.url = url
    self.formatter = formatter
  end

  def fetch_and_store_report!
    store_report(fetch_report)
  end

  private
  def fetch_report
    uri = URI(url)
    formatter.format(Net::HTTP.get(uri))
  end

  def store_report(report)
    WeatherReport.create!(report: report)
  end
end
