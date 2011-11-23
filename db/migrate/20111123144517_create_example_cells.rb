class CreateExampleCells < ActiveRecord::Migration
  def change
    create_table :example_cells do |t|
      t.integer :example_row_id
      t.string :name

      t.timestamps
    end
  end
end
