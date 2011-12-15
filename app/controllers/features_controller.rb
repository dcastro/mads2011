class FeaturesController < ApplicationController
  def show
    @feature = Feature.find(params[:id])
    @sc = SuggestionScenario.new
    @sc.feature = @feature
    
    @commentable = {type: "Feature", id: params[:id]}
  end

end
