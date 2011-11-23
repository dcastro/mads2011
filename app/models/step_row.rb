class StepRow < ActiveRecord::Base
  belongs_to :step
  has_many :step_cells, :dependent => :destroy
end
