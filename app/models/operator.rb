class Operator < ActiveRecord::Base
  # Relationships
  has_many :weather_reports

  # Validations
  validates_presence_of :city
  validates_presence_of :content_type
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :weather_url, presence: true, format: {with: URI.regexp}

  def self.current
    Thread.current[:current_operator]
  end

  def self.unconfigure
    Thread.current[:current_operator] = nil
  end

  def configure
    Thread.current[:current_operator] = self
  end

end
