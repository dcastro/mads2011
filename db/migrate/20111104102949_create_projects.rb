class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :role_id
      t.integer :feature_id
      t.string :name

      t.timestamps
    end
  end
end
