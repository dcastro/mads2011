class CreateSuggestionScenarios < ActiveRecord::Migration
  def change
    create_table :suggestion_scenarios do |t|
      t.integer :feature_id
      t.integer :user_id
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
