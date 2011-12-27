class SetProjectScriptsToDefault < ActiveRecord::Migration
  def up
    Project.all.each do |proj|
      proj.script = "bundle install\r\nbundle exec rake db:setup RAILS_ENV=test"
      proj.save
    end
  end

  def down
  end
end
