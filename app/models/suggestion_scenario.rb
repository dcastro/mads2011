class SuggestionScenario < ActiveRecord::Base
  belongs_to :feature
  belongs_to :user
  has_many :suggestion_steps
  
  validates :name, :presence  => true
  
  def dump
    f = File.new( "tmp/projects/" + self.feature.project.id.to_s + "/features/" + Time.now.to_i.to_s() + ".feature", "w")

    f.syswrite("Feature: #{self.feature.name }\n\n")
    f.syswrite("\tScenario: #{self.name}\n")
    
    self.suggestion_steps.each do |step|
    
      f.syswrite("\t\t#{step.keyword} #{step.name}\n")
      
      step.suggestion_rows.each do |row|
      
        f.syswrite("\t\t\t")  
          row.suggestion_cells.each do |cell|
           f.syswrite("| #{cell.name}\t")
          end
        f.syswrite("|\n")
      end
    end
    f.syswrite("\n")
  end
  
  
  
  def run
    Dir.chdir("tmp/projects/#{self.feature.project.id.to_s}") do
      %x[bundle install]
      %x[bundle exec rake db:setup RAILS_ENV=test]   
      cuke_result = %x[bundle exec cucumber features/#{ #todo } -f json RAILS_ENV=test]
    end
    
  end
  
end
