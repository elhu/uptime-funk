class CreateOutages < ActiveRecord::Migration
  def change
    create_table :outages do |t|
      t.datetime :started_at, index: true
      t.datetime :finished_at, index: true
      t.integer :operator_id, index: true
      t.integer :duration
      t.string :line, index: true
      t.string :type, index: true
      t.string :cause
      t.string :description


      t.timestamps null: false
    end
  end
end
