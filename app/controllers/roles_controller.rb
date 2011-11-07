class RolesController < ApplicationController
  def create
    @project = Project.find(params[:projectid])
    @role = Role.new(:name => params[:usertype], :user => User.find(params[:userid]), :project => @project)
    

    respond_to do |format|
      if @role.save
        format.html { redirect_to @project, notice: 'User was successfully added.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { redirect_to @project, notice: 'User was unsuccessfully added.' + @role.errors.full_messages.to_s }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    @project = Project.find(params[:projectid])
    @roles = Project.find(params[:projectid]).roles.where(["user_id = ?", params[:userid]])
    @roles.each do |role|
      
      if role.destroy
        format.html { redirect_to @project, notice: 'User was successfully removed.' }
        format.json { render json: @project, status: :removed, location: @project }
      else
        format.html { redirect_to @project, notice: 'User was unsuccessfully removed.' + @role.errors.full_messages.to_s }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
      
    end
    
  end

  def update
  end

end
