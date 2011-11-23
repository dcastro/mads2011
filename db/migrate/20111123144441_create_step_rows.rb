class CreateStepRows < ActiveRecord::Migration
  def change
    create_table :step_rows do |t|
      t.integer :step_id

      t.timestamps
    end
  end
end
