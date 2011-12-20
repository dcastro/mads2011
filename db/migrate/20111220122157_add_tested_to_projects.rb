class AddTestedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :tested, :boolean
  end
end
