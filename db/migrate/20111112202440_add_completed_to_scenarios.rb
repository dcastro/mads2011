class AddCompletedToScenarios < ActiveRecord::Migration
  def change
    add_column :scenarios, :completed, :boolean
  end
end
