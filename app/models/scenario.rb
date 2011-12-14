class Scenario < ActiveRecord::Base
  belongs_to :feature
  has_many :steps, :dependent => :destroy
  has_one :example, :dependent => :destroy
  
  has_many :comments, :as => :commentable
  
  #validates :name, :line, :presence => true
  
  
end
