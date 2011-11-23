class CreateExampleRows < ActiveRecord::Migration
  def change
    create_table :example_rows do |t|
      t.integer :scenario_id

      t.timestamps
    end
  end
end
