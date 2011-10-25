class UserController < ApplicationController
  def home
    
  end
  
  def login
    if user = User.authenticate(params[:username], params[:password])
      session[:username] = user.username
    end
    
    respond_to do |format|
      format.html {  }
    end    
  end

  def logout
    session[:username] = nil
  end

  def show
  end
  
  def create
    
  end

end
