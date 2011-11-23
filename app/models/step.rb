class Step < ActiveRecord::Base
  belongs_to :scenario
  has_many :step_rows, :dependent => :destroy

  
  validates :keyword, :name, :line, :status, :location, :presence => true
end
