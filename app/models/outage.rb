class Outage < ActiveRecord::Base
  include OperatorSharding

  belongs_to :line
  before_create :set_started_at

  validates_presence_of :line, :outage_type

  scope :within, ->(date_range) { where('boundaries && tstzrange(?, ?)', date_range.begin, date_range.end) }

  def self.default_end_time
    1000.years.from_now
  end

  def started_at
    boundaries.begin
  end

  def finished_at
    boundaries.end
  end

  def close!(finish = Time.now)
    update_attributes!({
      boundaries: (self.boundaries.begin)..finish,
      duration: finish - self.boundaries.begin
    })
  end

  def to_log_string(action)
    "[#{operator.name}] #{action} outage for #{line}: #{outage_type} - #{description}"
  end

  private
  def set_started_at
    self.boundaries ||= Time.now..(self.class.default_end_time)
  end
end
