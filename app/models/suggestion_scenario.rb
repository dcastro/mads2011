class SuggestionScenario < ActiveRecord::Base
  belongs_to :feature
  has_many :suggestion_steps
  
  validates :name, :presence  => true
end
