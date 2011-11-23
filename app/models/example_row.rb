class ExampleRow < ActiveRecord::Base
  belongs_to :example
  has_many :example_cells, :dependent => :destroy
end
