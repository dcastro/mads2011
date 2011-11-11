class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.integer :feature_id
      t.string :name
      t.integer :line
      t.text :description

      t.timestamps
    end
  end
end
