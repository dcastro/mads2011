class SuggestionCell < ActiveRecord::Base
  
  default_scope :order => 'order'
  
  belongs_to :suggestion_row
  
end
