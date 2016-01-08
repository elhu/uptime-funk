class StatusController < ApplicationController
  def index
    @lines = Line.all.order(line_type: :asc, position: :asc).includes(:ongoing_outage)
  end
end
