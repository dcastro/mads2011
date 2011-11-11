class Feature < ActiveRecord::Base
  belongs_to :project
  has_many :scenarios
  
  validates :name, :presence  => true
end
