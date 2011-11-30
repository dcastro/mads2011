class SuggestionScenariosController < ApplicationController
  def create
    @sc = SuggestionScenario.new params[:suggestion_scenario]
    @sc.user = current_user
    
    @steps = Hash[params[:keyword].zip(params[:name])]
    
    @steps.each do |keyword, name|
      @sc.suggestion_steps.build keyword: keyword, name: name
    end  
    
    @sc.save!
    
  end

  def destroy
  end

end
