class AddOperatorIdToWeatherReports < ActiveRecord::Migration
  def change
    add_column :weather_reports, :operator_id, :integer
  end
end
