class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @projects = User.find(session[:id]).projects

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @user_type = @project.roles.where(:user_id => session[:id]).first.name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @project.roles.build name: Role.role_types.first,
                         user: User.find(session[:id])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    
    @project.users.each do |u|
      Notifier.project_deleted(@project, current_user, u.email ).deliver
    end
    
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end
  
  
  def update_state
    project = Project.find(params[:id])
    project.features.destroy_all
    project.repo
    
    str = "git clone " + project.repo + " tmp/projects/" + project.id.to_s
    %x[#{str}]
    
    #TODO:  fazer parse em caso de erro
    #p "**************************************************************************"
    filenames = Dir.glob("tmp/projects/#{project.id.to_s}/features/*.feature")
    #p "**************************************************************************"
    filenames.each do |f|
      file = File.open("#{f}")
      primeira_linha = file.first.chomp
      feature_name = primeira_linha.split(": ")[1]
      project.features.create!(name: feature_name, done: false)
      file.close
    end

=begin    
    p "***************BUNDLE INSTALL *****************"
    p %x[cd tmp/projects/#{project.id.to_s} & bundle install]
    
    p "***************RAKE *****************"
    puts %x[cd tmp/projects/#{project.id.to_s} & bundle exec rake db:setup RAILS_ENV=test]
    
    p "***************CUCUMBER *****************"
=end

    Dir.chdir("tmp/projects/#{project.id.to_s}") do
      %x[bundle install]
      %x[rake db:setup RAILS_ENV=test]   
      cuke_result = %x[bundle exec cucumber -f json RAILS_ENV=test]
      #puts cuke_result
      parsed_msg =cuke_result.match(/[^\[]*(.*)/).to_a
      parsed_msg = parsed_msg.second
      
      json = ActiveSupport::JSON.decode(parsed_msg)
      
       json.each do |feature|
         feature_name = feature["name"]
         feature_description = feature["description"]
         
          #inserir na BD e obter id
                  
         scenario_array = fearure["elements"]
         scenario_array.each do |scenario|
           
            scenario_name = scenario["name"]
            scenario_line = scenario["line"]
            scenario_description = scenario["description"]
          
            #inserir na BD e obter id
          
            step_array = scenario["steps"]
            step_array do |step|
           
              step_keyword = step["keyword"]
              step_name = step["name"]
              step_line = step["line"]
              step_status = step["result"]["status"]
              
              step_err_msg
              #pode dar erro aqui porque so existe emnsagem de erro caso de erro
              if step_status == "failed"
                step_err_msg = step["result"]["error_message"] 
              
              
              #inserir na bd
            
            end
          end
         
         end
         
      end
      
    end
    
    
    respond_to do |format|
      FileUtils.rm_rf "tmp/projects/" + project.id.to_s
      format.html { redirect_to project_url(project), notice: "Project updated successfully." }
      format.json { head :ok }
      
    end
  end
end
