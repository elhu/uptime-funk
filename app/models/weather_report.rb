class WeatherReport < ActiveRecord::Base
  include OperatorSharding

  # Validations
  validates_presence_of :report
end
