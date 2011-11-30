class AddNameToSuggestionCell < ActiveRecord::Migration
  def change
    add_column :suggestion_cells, :name, :string
  end
end
