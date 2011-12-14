class SuggestionScenario < ActiveRecord::Base
  belongs_to :feature
  belongs_to :user
  has_many :suggestion_steps
  
  has_many :comments, :as => :commentable
  
  validates :name, :presence  => true
  
  def dump
    filename =  Time.now.to_i.to_s() + ".feature"
    f = File.new( "tmp/projects/" + self.feature.project.id.to_s + "/features/" + filename, "w")

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
    
    return filename
  end
  
  
  
  def run(filename)
    Dir.chdir("tmp/projects/#{self.feature.project.id.to_s}") do
      %x[bundle install]
      %x[bundle exec rake db:setup RAILS_ENV=test]   
      cuke_result = %x[bundle exec cucumber features/#{ filename } -f json RAILS_ENV=test]
      
      parsed_msg =cuke_result.match(/[^\[]*(.*)/).to_a      
      parsed_msg = parsed_msg.second

      json = ActiveSupport::JSON.decode(parsed_msg)
      
      steps = json.first["elements"].first["steps"]
      
      steps.each_with_index do |step, index|
        self.suggestion_steps[index].status = step["result"]["status"]
        self.suggestion_steps[index].error_msg = step["result"]["error_message"] || nil
        self.suggestion_steps[index].save
      end
      
      
    end
    
  end
  
end
