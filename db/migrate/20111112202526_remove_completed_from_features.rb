class RemoveCompletedFromFeatures < ActiveRecord::Migration
  def up
    remove_column :features, :completed
  end

  def down
    add_column :features, :completed, :boolean
  end
end
