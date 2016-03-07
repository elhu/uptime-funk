module ApplicationHelper
  def outage_description(outage)
    outage.description.gsub(/\d{2}\/\d{2}\/\d{2}, \d{2}:\d{2}, /, '').capitalize
  end
end
