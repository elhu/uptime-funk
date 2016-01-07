class ForceLineOrdering < ActiveRecord::Migration
  def change
    add_column :lines, :position, :integer, index: true

    Operator.first.configure

    # Rename tramway to tram
    Line.where(line_type: 'tramway').update_all(line_type: 'tram')
    Line.where(line_type: 'tram').each { |tram| tram.update_attributes(name: tram.name.gsub('T', '')) }

    line_data = [{:line_type=>"metro", :name=>"1", :position=>1}, {:line_type=>"metro", :name=>"2", :position=>2}, {:line_type=>"metro", :name=>"3", :position=>3}, {:line_type=>"metro", :name=>"3b", :position=>4}, {:line_type=>"metro", :name=>"4", :position=>5}, {:line_type=>"metro", :name=>"5", :position=>6}, {:line_type=>"metro", :name=>"6", :position=>7}, {:line_type=>"metro", :name=>"7", :position=>8}, {:line_type=>"metro", :name=>"7b", :position=>9}, {:line_type=>"metro", :name=>"8", :position=>10}, {:line_type=>"metro", :name=>"9", :position=>11}, {:line_type=>"metro", :name=>"10", :position=>12}, {:line_type=>"metro", :name=>"11", :position=>13}, {:line_type=>"metro", :name=>"12", :position=>14}, {:line_type=>"metro", :name=>"13", :position=>15}, {:line_type=>"metro", :name=>"14", :position=>16}, {:line_type=>"rer", :name=>"A", :position=>1}, {:line_type=>"rer", :name=>"B", :position=>2}, {:line_type=>"tram", :name=>"T1", :position=>1}, {:line_type=>"tram", :name=>"T2", :position=>2}, {:line_type=>"tram", :name=>"T3a", :position=>3}, {:line_type=>"tram", :name=>"T3b", :position=>4}, {:line_type=>"tram", :name=>"T5", :position=>6}, {:line_type=>"tram", :name=>"T6", :position=>7}, {:line_type=>"tram", :name=>"T7", :position=>8}, {:line_type=>"tram", :name=>"T8", :position=>9}]
    line_data.each do |line|
      Line.where(line_type: line[:line_type], name: line[:name]).first.update_attributes(position: line[:position])
    end
  end
end
