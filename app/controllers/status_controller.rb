class StatusController < ApplicationController
  def index
    @lines = Line.all.order(line_type: :asc, position: :asc).includes(:ongoing_outage)

    # Refactor: move this and associated methods to a dedicated class
    raw_outages = Outage.within((1.week.ago.beginning_of_day)..(Time.now))
    @outages = raw_outages.inject(Hash.new { Hash.new(0) }) do |memo, curr|
      memo[curr.line_id] = memo[curr.line_id].merge(bucketted_times_for(curr)) do |key, prev_val, new_val|
        prev_val + new_val
      end
      memo
    end
  end

  private
  def bucketted_times_for(outage, bucket_size: 1.hour)
    bucket_start = nearest_bucket(outage.started_at, bucket_size)
    buckets = {}
    while bucket_start < outage.finished_at
      buckets[bucket_start] = time_in_bucket(outage, bucket_start, bucket_size)
      bucket_start += bucket_size
    end
    buckets
  end

  def nearest_bucket(t, bucket_size)
    t - t.to_i % bucket_size
  end

  def time_in_bucket(outage, bucket_start, bucket_size)
    bucket_end = bucket_start + bucket_size
    if outage.started_at > bucket_start && outage.finished_at < bucket_end
      outage.duration
    elsif outage.started_at > bucket_start
      (bucket_end - outage.started_at) % bucket_size
    elsif outage.finished_at < bucket_end
      bucket_size - (bucket_end - outage.finished_at)
    else
      bucket_size
    end
  end
end
