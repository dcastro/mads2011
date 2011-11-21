class CreateSuggestionSteps < ActiveRecord::Migration
  def change
    create_table :suggestion_steps do |t|
      t.integer :suggestion_scenario_id
      t.string :name
      t.string :keyword

      t.timestamps
    end
  end
end
