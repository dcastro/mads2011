class RenameOrderColumn < ActiveRecord::Migration
  def up
    rename_column :suggestion_rows, :order, :row_num
    rename_column :suggestion_cells, :order, :cell_num
  end

  def down
  end
end
