class RemoveRoleIdFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :role_id
  end

  def down
    add_column :projects, :role_id, :integer
  end
end
