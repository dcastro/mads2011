class Step < ActiveRecord::Base
  belongs_to :scenario
  has_many :step_rows, :dependent => :destroy
  
  has_many :comments, :as => :commentable

  
  validates :keyword, :name, :line, :status, :presence => true
end
