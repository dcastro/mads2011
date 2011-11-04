class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  
  
  protected
    def authorize
      unless User.find_by_id(session[:id])
        redirect_to home_url, :notice => "Please log in"
      end
    end
end
