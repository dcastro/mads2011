class ImplementedStepsController < ApplicationController
  def match
    
    string = params[:string]
    
    steps = Project.find(params[:project_id]).implemented_steps.select do |step|
       step.match(string)
    end
    
    render json: steps.collect( &:name )    
  end

end
