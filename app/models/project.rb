class Project < ActiveRecord::Base
  has_many :roles
  
  validates :name, :repo, :presence => true
end
