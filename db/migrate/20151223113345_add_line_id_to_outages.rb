class AddLineIdToOutages < ActiveRecord::Migration
  def change
    rename_column :outages, :line, :line_name
    add_column :outages, :line_id, :integer, index: true
    Operator.first.configure
    Outage.distinct(:line_name).pluck(:line_name).each do |line|
      full_name = line
      type, name = line.split(' ')
      type = ActiveSupport::Inflector.transliterate(type.downcase)
      Line.create!(operator_label: full_name, line_type: type, name: name)
    end
    Line.all.each do |line|
      say "Processing outages for line #{line.operator_label}"
      scope = Outage.where(line_name: line.operator_label)
      say "  found #{scope.count} outages"
      scope.update_all(line_id: line)
    end
    remove_column :outages, :line_name
  end
end
