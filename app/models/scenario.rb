class Scenario < ActiveRecord::Base
  belongs_to :feature
  
  validates :name, :line, :presence => true
  
  
end
