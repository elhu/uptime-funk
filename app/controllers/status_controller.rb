class StatusController < ApplicationController
  def index
    @lines = Line.all.order(line_type: :asc, position: :asc).includes(:ongoing_outage)

    # Refactor: there is probably some nicer/smarter ways to do that
    @outages = Outage.within((1.week.ago.beginning_of_day)..(Time.now)).group_by { |outage| outage.line_id }
    @outages.each do |line_id, outages|
      grouped_outages = outages.group_by { |outage| outage.started_at.beginning_of_day }
      grouped_outages.each do |date, values|
        grouped_outages[date] = values.sum(&:duration)
      end
      @outages[line_id] = grouped_outages
    end
  end
end
