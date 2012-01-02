class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  ROLE_TYPES = ["Manager", "Developer", "Client"]
  validates :name, :inclusion => ROLE_TYPES
  
  validates :user_id, :uniqueness => {:scope => :project_id}
  
  def self.role_types
    ROLE_TYPES
  end
  
  
  
  
end
