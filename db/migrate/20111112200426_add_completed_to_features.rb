class AddCompletedToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :completed, :boolean
  end
end
