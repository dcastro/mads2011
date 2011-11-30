class SuggestionCell < ActiveRecord::Base
  
  default_scope :order => 'cell_num'
  
  belongs_to :suggestion_row
  
end
