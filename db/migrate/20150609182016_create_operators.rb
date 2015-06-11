class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.string :name
      t.string :city
      t.string :country
      t.string :weather_url
      t.string :website

      t.timestamps null: false
    end
  end
end
