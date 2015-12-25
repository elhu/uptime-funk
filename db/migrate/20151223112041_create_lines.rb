class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :operator_id, index: true
      t.string :line_type
      t.string :name
      t.string :operator_label

      t.timestamps null: false
    end
  end
end
