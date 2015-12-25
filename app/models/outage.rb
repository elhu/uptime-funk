class Outage < ActiveRecord::Base
  include OperatorSharding

  belongs_to :line
  before_create :set_started_at

  validates_presence_of :line, :outage_type

  def close!(finish = Time.now)
    update_attributes!({
      finished_at: finish,
      duration: finish - self.started_at
    })
  end

  def set_started_at
    self.started_at ||= Time.now
  end

  def to_log_string(action)
    "[#{operator.name}] #{action} outage for #{line}: #{outage_type} - #{description}"
  end
end
