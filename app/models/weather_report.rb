class WeatherReport < ActiveRecord::Base
  include OperatorSharding

  # Validations
  validates_presence_of :report

  def api_time
    @api_time ||= begin
      ts = created_at
      api_hour = report['now'].split(':').map(&:to_i)
      Time.find_zone('Paris').local(ts.year, ts.month, ts.day, api_hour.first, api_hour.last)
    end
  end
end
