class SuggestionRow < ActiveRecord::Base
  
  default_scope :order => 'row_num'
  
  belongs_to :suggestion_step
  
  has_many :suggestion_cells, :dependent => :destroy
end
