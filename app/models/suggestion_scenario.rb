class SuggestionScenario < ActiveRecord::Base
  belongs_to :feature
  
  validates :name, :presence  => true
end
