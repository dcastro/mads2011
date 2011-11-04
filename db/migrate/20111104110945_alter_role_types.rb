class AlterRoleTypes < ActiveRecord::Migration
  def up
    rename_column :roles, :type, :name
  end

  def down
  end
end
