class AddContentTypeToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :content_type, :string
  end
end
