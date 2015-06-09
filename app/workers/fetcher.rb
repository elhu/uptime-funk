class Fetcher
  include Sidekiq::Worker

  def perform(operator_id)
    operator = Operator.find(operator_id).configure
    formatter = formatter_for(operator.content_type)
    ReportFetcher.new(url: operator.weather_url, formatter: formatter).fetch_and_store_report!
  end

  private
  # Returns the formatter for a specific content-type
  #
  # If we were to be pure OOP, that should be in its own Factory class.
  # Will move if the logic grows too much.
  #
  # format - json, xml, whatevever
  #
  # Returns the formatter
  def formatter_for(content_type)
    case content_type
    when 'application/json'
      ReportFormatter::JSON.new
    end
  end

end
