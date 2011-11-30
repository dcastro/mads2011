class CreateSuggestionRows < ActiveRecord::Migration
  def change
    create_table :suggestion_rows do |t|
      t.integer :suggestion_step_id
      t.integer :order

      t.timestamps
    end
  end
end
