class BuckettedOutageDuration
  attr_accessor :bucket_size, :time_period, :time_period_as_time, :buckets, :ticks

  def initialize(time_period:, bucket_size:)
    self.time_period_as_time = time_period
    self.bucket_size = bucket_size
    self.time_period = nearest_bucket(time_period.begin.to_i)..(time_period.end.to_i)
    self.ticks = self.time_period.step(bucket_size).to_a
  end

  def fetch
    initialize_buckets
    raw_outages = scope

    raw_outages.each do |curr_outage|
      ticks.each do |bucket_start|
        buckets[curr_outage.line_id][bucket_start] += time_in_bucket(curr_outage, bucket_start)
      end
    end
    buckets
  end

  def uptime_percentage
    max_duration = (time_period_as_time.end - time_period_as_time.begin)
    total_durations.inject({}) do |orig, (k, v)|
      orig[k] = 1 - v / max_duration.to_f
      orig
    end
  end

  def total_durations
    scope.group(:line_id).sum(:duration)
  end

  def outages_count
    scope.group(:line_id).count
  end

  private
  def initialize_buckets
    self.buckets = Line.pluck(:id).map do|id|
      [id, ticks.zip(Array.new(ticks.length) { 0 }).to_h]
    end.to_h
  end

  def nearest_bucket(t)
    t - t % bucket_size
  end

  def time_in_bucket(outage, bucket_start)
    bucket_end = bucket_start + bucket_size
    started_at = outage.started_at.to_i
    finished_at = outage.finished_at.to_i
    return 0 if started_at > bucket_end or finished_at < bucket_start
    [bucket_end, finished_at].min - [bucket_start, started_at].max
  end

  def scope
    @scope ||= Outage.within(time_period_as_time)
  end
end
