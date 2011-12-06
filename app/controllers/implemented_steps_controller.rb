class ImplementedStepsController < ApplicationController
  def match
    
    string = params[:string]
    
    steps = Project.find(params[:project_id]).implemented_steps.select do |step|
      
      string.match( Regexp.new(step) )
      
    end
    
    render json: steps
    
    
    
    
  end

end
