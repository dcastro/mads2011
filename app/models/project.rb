class Project < ActiveRecord::Base
  has_many :roles, :dependent => :destroy
  has_many :users, :through => :roles
  has_many :features
  
  validates :name, :repo, :presence => true
end
