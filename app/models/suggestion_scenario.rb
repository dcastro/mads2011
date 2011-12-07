class SuggestionScenario < ActiveRecord::Base
  belongs_to :feature
  belongs_to :user
  has_many :suggestion_steps
  
  validates :name, :presence  => true
  
  def dump
    
    
    f = File.new(Time.now.to_i.to_s(), "w")
    puts f.path()
    f.syswrite("Feature: ")
    f.syswrite(self.feature.name)
    f.syswrite("\n\n")
    
    f.syswrite("\tScenario: ")
    f.syswrite(self.name)
    f.syswrite("\n")
    
    self.suggestion_steps.each do |step|
    
      f.syswrite("\t\t")
      f.syswrite(step.keyword)
      f.syswrite(" ")
      f.syswrite(step.name)
      f.syswrite("\n")
      
      step.suggestion_rows.each do |row|
      
        f.syswrite("\t\t\t")  
          row.suggestion_cells.each do |cell|
           f.syswrite("| ") 
           f.syswrite(cell.name)
           f.syswrite("\t")
            
          end
        
        f.syswrite("|\n")
       
      end
      
    end
      
    f.syswrite("\n")
    # <%= button_to "Try running", suggestion_scenarios_run_test_path(id: scenario.id), :method => :get %>
    
  end
  
end
