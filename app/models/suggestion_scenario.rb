class SuggestionScenario < ActiveRecord::Base
  belongs_to :feature
  belongs_to :user
  has_many :suggestion_steps
  
  validates :name, :presence  => true
  
  def dump
    
    
    f = File.new(Time.now.to_i.to_s() + ".feature", "w")
    puts f.path()
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
  
end
