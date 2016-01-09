class SwitchOutagesToTstzranges < ActiveRecord::Migration
  def change
    add_column :outages, :boundaries, :tstzrange, index: true

    Outage.all.each do |outage|
      outage.update_attributes!(boundaries: (outage.attributes['started_at'])..(outage.attributes['finished_at'].presence || Outage.default_end_time))
    end
    remove_column :outages, :started_at
    remove_column :outages, :finished_at
  end
end
