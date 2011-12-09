class SuggestionScenariosController < ApplicationController
  def create
    @sc = SuggestionScenario.new params[:suggestion_scenario]
    @sc.user = current_user
    
    @steps = params[:keyword].zip(params[:name])
    
    @steps.each do |keyword, name|
      @sc.suggestion_steps.build keyword: keyword, name: name
    end
    
    if params[:row]
      params[:row].each do |index, rows|
        rows.each do |row_num, cells|
          @sc.suggestion_steps[index.to_i].suggestion_rows.build row_num: row_num
          
          for i in 0..(cells.length-1)
            @sc.suggestion_steps[index.to_i].suggestion_rows.last.suggestion_cells.build cell_num: i, name: cells[i]
          end
        end
      end
    end    
    
    if @sc.save
      redirect_to features_show_url(id: @sc.feature_id )
    else
      redirect_to features_show_url(id: @sc.feature_id ), notice: "Invalid Suggestion"
    end
    
  end

  def destroy
    suggestion = SuggestionScenario.find(params[:suggestion_scenario_id])
    id = suggestion.feature.id
    
    if suggestion.destroy
      redirect_to features_show_url(id: id), notice: "Suggestion successfully deleted."
    else
      redirect_to features_show_url(id: id), notice: "An error occurred while trying to delete the suggestion."
    end
    
  end
  
  def run_test
    
    suggestion = SuggestionScenario.find(params[:id])
    
    suggestion.feature.project.download
    suggestion.dump
    suggestion.run
    
    
    #render nothing: true
    
  end

end
