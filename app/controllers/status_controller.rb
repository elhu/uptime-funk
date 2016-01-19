class StatusController < ApplicationController
  def index
    @lines = Line.all.order(line_type: :asc, position: :asc).includes(:ongoing_outage)

    time_period = (6.days.ago.beginning_of_day)..(Time.now)
    @outages = BuckettedOutageDuration.new(time_period: time_period, bucket_size: 1.day).fetch
  end
end
