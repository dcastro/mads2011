class RemoveFeatureIdFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :feature_id
  end

  def down
    add_column :projects, :feature_id, :integer
  end
end
