class RenamePhotoColumn < ActiveRecord::Migration
  def up
    rename_column :users, :photo, :photo_file_name
  end

  def down
  end
end
