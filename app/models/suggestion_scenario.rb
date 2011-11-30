class SuggestionScenario < ActiveRecord::Base
  belongs_to :feature
  belongs_to :user
  has_many :suggestion_steps
  
  validates :name, :presence  => true
end
