class ImplementedStepsController < ApplicationController
  def match
    
    string = params[:string]
    
    #steps = Project.find(params[:project_id]).implemented_steps.select do |step|
    #   step.match(string)
    #end
    steps = Project.find(params[:project_id]).implemented_steps.collect do |step|
      {name: step.name, match: step.match(string)}
    end
    
    render json: steps.select{|step| step[:match] }.first(7)    
  end

end
