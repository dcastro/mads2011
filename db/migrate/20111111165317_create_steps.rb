class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :scenario_id
      t.string :keyword
      t.string :name
      t.integer :line
      t.string :location
      t.string :status
      t.text :error_msg

      t.timestamps
    end
  end
end
