class SuggestionStep < ActiveRecord::Base
  belongs_to :suggestion_scenario
  
  validates :name, :keyword, :presence => true
end
