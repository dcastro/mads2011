class Project < ActiveRecord::Base
  has_many :roles, :dependent => :destroy
  has_many :users, :through => :roles
  has_many :features
  has_many :implemented_steps
  
  validates :name, :repo, :presence => true
end
