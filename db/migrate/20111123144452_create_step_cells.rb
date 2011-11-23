class CreateStepCells < ActiveRecord::Migration
  def change
    create_table :step_cells do |t|
      t.integer :step_row_id
      t.string :name

      t.timestamps
    end
  end
end
