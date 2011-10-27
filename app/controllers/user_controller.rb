class UserController < ApplicationController
  def home
    
  end
  
  def login
    if user = User.authenticate(params[:username], params[:password])
      session[:username] = user.username
    end
    
    respond_to do |format|
      format.html { redirect_to home_url }
    end    
  end

  def logout
    session[:username] = nil
    
    respond_to do |format|
      format.html { redirect_to home_url }
    end    
  end

  def show
  end
  
  def create
    
  end

end
