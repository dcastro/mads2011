class Feature < ActiveRecord::Base
  belongs_to :project
  has_many :scenarios, :dependent => :destroy
  has_many :suggestion_scenarios
  
  has_many :comments, :as => :commentable
  
  validates :name, :presence  => true
end
