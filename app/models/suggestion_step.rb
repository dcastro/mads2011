class SuggestionStep < ActiveRecord::Base
  belongs_to :suggestion_scenario
  
  has_many :suggestion_rows, :dependent => :destroy
  
  validates :name, :keyword, :presence => true
end
