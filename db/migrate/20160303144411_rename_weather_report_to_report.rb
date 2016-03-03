class RenameWeatherReportToReport < ActiveRecord::Migration
  def change
    rename_table :weather_reports, :reports
    rename_column :operators, :weather_url, :report_url
  end
end
