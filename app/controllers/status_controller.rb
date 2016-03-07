class StatusController < ApplicationController
  def index
    @lines = Line.all.order(line_type: :asc, position: :asc).includes(:ongoing_outage)

    time_period = (30.days.ago)..(Time.now)
    # time_period = (3.weeks.ago)..(Time.now)
    duration_helper = BuckettedOutageDuration.new(time_period: time_period, bucket_size: 1.day)
    @outages = duration_helper.fetch
    @uptime_percentages = duration_helper.uptime_percentage
    @outage_counts = duration_helper.outages_count
  end
end
