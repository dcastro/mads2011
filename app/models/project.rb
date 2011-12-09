class Project < ActiveRecord::Base
  has_many :roles, :dependent => :destroy
  has_many :users, :through => :roles
  has_many :features
  has_many :suggestion_scenarios, :through => :features
  has_many :implemented_steps
  
  validates :name, :repo, :presence => true
  
  def download
    
    FileUtils.rm_rf "tmp/projects/" + self.id.to_s
    
    str = "git clone " + self.repo + " tmp/projects/" + self.id.to_s
    %x[#{str}]
  end
  
  
end
