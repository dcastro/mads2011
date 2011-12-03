class StepCell < ActiveRecord::Base
  belongs_to :step_row  
  #validates :name, :presence  => true
end
