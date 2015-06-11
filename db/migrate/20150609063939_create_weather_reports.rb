class CreateWeatherReports < ActiveRecord::Migration
  def change
    create_table :weather_reports do |t|
      t.jsonb :report

      t.timestamps null: false
    end
  end
end
