class CreateImplementedSteps < ActiveRecord::Migration
  def change
    create_table :implemented_steps do |t|
      t.string :filename
      t.string :name
      t.integer :project_id

      t.timestamps
    end
  end
end
