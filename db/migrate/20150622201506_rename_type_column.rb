class RenameTypeColumn < ActiveRecord::Migration
  def change
    rename_column :outages, :type, :outage_type
  end
end
