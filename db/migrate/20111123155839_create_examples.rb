class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.integer :scenario_id
      t.text :keyword
      t.text :name
      t.text :description
      t.integer :line

      t.timestamps
    end
  end
end
