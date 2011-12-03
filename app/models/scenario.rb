class Scenario < ActiveRecord::Base
  belongs_to :feature
  has_many :steps, :dependent => :destroy
  has_one :example, :dependent => :destroy

  
  #validates :name, :line, :presence => true
  
  
end
