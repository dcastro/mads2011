class Step < ActiveRecord::Base
  belongs_to :scenario
  
  validates :keyword, :name, :line, :status, :location, :presence => true
end
