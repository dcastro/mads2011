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
          @sc.suggestion_steps[index.to_i].suggestion_rows.build order: row_num
          
          for i in 0..(cells.length-1)
            @sc.suggestion_steps[index.to_i].suggestion_rows.last.suggestion_cells.build order: i, name: cells[i]
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
  end

end
