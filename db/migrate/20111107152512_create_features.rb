class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :project_id
      t.string :name
      t.text :description
      t.boolean :done

      t.timestamps
    end
  end
end
