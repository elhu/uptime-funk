class Outage < ActiveRecord::Base
  include OperatorSharding

  before_create :set_started_at

  validates_presence_of :line, :type

  def close!(finish = Time.now)
    update_attributes({
      finished_at: finish,
      duration: finish - self.started_at
    })
  end

  def set_started_at
    self.started_at ||= Time.now
  end
end
