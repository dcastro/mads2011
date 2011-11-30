class CreateSuggestionCells < ActiveRecord::Migration
  def change
    create_table :suggestion_cells do |t|
      t.integer :suggestion_row_id
      t.integer :order

      t.timestamps
    end
  end
end
