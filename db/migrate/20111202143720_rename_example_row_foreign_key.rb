class RenameExampleRowForeignKey < ActiveRecord::Migration
  def up
    rename_column :example_rows, :scenario_id, :example_id
  end

  def down
  end
end
