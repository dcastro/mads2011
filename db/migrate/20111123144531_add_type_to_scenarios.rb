class AddTypeToScenarios < ActiveRecord::Migration
  def change
    add_column :scenarios, :type, :string
  end
end
