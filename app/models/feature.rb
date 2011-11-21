class Feature < ActiveRecord::Base
  belongs_to :project
  has_many :scenarios, :dependent => :destroy
  has_many :suggestion_scenarios
  
  validates :name, :presence  => true
end
