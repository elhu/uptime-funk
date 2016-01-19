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
    raw_outages = Outage.within(time_period_as_time)

    raw_outages.each do |curr_outage|
      buckets[curr_outage.line_id].merge!(bucketted_durations_for(curr_outage)) do |key, prev_val, new_val|
        prev_val + new_val
      end
    end
    buckets
  end

  private
  def initialize_buckets
    self.buckets = Line.pluck(:id).map do|id|
      [id, ticks.zip(Array.new(ticks.length) { 0 }).to_h]
    end.to_h
  end

  def bucketted_durations_for(outage)
    buckets = {}
    ticks.each do |bucket_start|
      time_in_bucket(outage, bucket_start)
      buckets[bucket_start] = time_in_bucket(outage, bucket_start)
    end
    buckets
  end

  def nearest_bucket(t)
    t - t % bucket_size
  end

  def time_in_bucket(outage, bucket_start)
    bucket_end = bucket_start + bucket_size
    [[bucket_end, outage.finished_at.to_i].min - [bucket_start, outage.started_at.to_i].max, 0].max
  end
end
