class AddGithubFieldsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :github_username, :string
    add_column :projects, :github_repo, :string
    add_column :projects, :script, :text
  end
end
