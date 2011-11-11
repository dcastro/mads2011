class Feature < ActiveRecord::Base
  belongs_to :project
  has_many :scenarios, :dependent => :destroy
  
  validates :name, :presence  => true
end
