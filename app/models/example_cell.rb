class ExampleCell < ActiveRecord::Base
  belongs_to :example_row
  validates :name, :presence  => true
end
