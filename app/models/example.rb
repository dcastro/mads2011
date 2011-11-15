class Example < ActiveRecord::Base
  belongs_to :scenario
  has_many :example_rows, :dependent => :destroy
  
  #validates :keyword, :line, :presence  => true
end

