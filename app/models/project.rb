class Project < ActiveRecord::Base
  has_many :roles, :dependent => :destroy
  has_many :users, :through => :roles
  has_many :features
  has_many :suggestion_scenarios, :through => :features
  has_many :implemented_steps
  
  validates :name, :repo, :presence => true
  
  #after_initialize :set_default_script
  
  #def set_default_script
  #  self.script = "bundle install\r\nbundle exec rake db:setup RAILS_ENV=test"
  #end
  
  def download
    
    self.clean_up
    
    str = "git clone " + self.repo + " tmp/projects/" + self.id.to_s
    %x[#{str}]
  end
  
  def clean_up
    FileUtils.rm_rf "tmp/projects/" + self.id.to_s    
  end
  
  
  def get_stats
    self.features.collect do |f| 
      [f.name, (f.scenarios.count > 0)? (f.scenarios.where(:completed => true).count.to_f / f.scenarios.count.to_f) : 0]
    end
  end
  
  
end
