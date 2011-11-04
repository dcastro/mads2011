class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :type
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
