class SuggestionScenariosController < ApplicationController
  def create
    SuggestionScenario.new params[:suggestion_scenario]
    
    @steps = Hash[params[:keyword].zip(params[:name])]
    
    p "**********************************************"
    p @steps
    
  end

  def destroy
  end

end
