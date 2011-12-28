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
    
    @stats = @project.get_stats
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new script: "bundle install\r\nbundle exec rake db:setup RAILS_ENV=test"

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
    
    respond_to do |format|
      if current_user.role_in_project(@project.id) == "Manager"
        @project.users.each do |u|
          Notifier.project_deleted(@project, current_user, u.email ).deliver
        end
        
        @project.destroy
      
        format.html { redirect_to projects_url }
        format.json { head :ok }
      else
        format.html { redirect_to projects_url, notice: "Only managers are allowed to destroy this project." }
        format.json { head :method_not_allowed }
      end
    end
  end
  
  
  def update_state
    project = Project.find(params[:id])
    project.features.destroy_all
    
    FileUtils.rm_rf "tmp/projects/" + project.id.to_s
    
    str = "git clone " + project.get_git_url + " tmp/projects/" + project.id.to_s
    %x[#{str}]
    
    filenames = Dir.glob("tmp/projects/#{project.id.to_s}/features/*.feature")

    #change dir
    Dir.chdir("tmp/projects/#{project.id.to_s}") do
      
      #execute user script
      project.script.split(/\n|\r\n/).each do |line|
         %x[#{line}]
      end
      
      #execute cucumber
      cuke_result = %x[bundle exec cucumber -f json -f pdf --out ../../../public/reports/#{project.id.to_s}.pdf RAILS_ENV=test]
      
      project.tested = true
      project.save
      
      #remove irrelevant info
      parsed_msg =cuke_result.match(/[^\[]*(.*)/).to_a
      parsed_msg = parsed_msg.second
      
      #parse do resultado dos testes
      json = ActiveSupport::JSON.decode(parsed_msg)
      
       json.each do |feature|
          feature_completed = true
          @feature = Feature.new  :name => feature["name"],
                                  :description => feature["description"],
                                  :project => project
          
                  
         feature["elements"].each do |scenario|
            scenario_completed = true
            @feature.scenarios.build :name => scenario["name"],
                                    :line => scenario["line"],
                                    :description => scenario["decription"],
                                    :type => scenario["type"]

           
            if scenario["type"] == "scenario_outline"

              example = scenario["examples"].first

              @feature.scenarios.last.build_example :keyword =>  example["keyword"],
                                                    :name =>  example["name"],
                                                    :line =>  example["line"],
                                                    :description =>  example["description"]
                
              
              example["rows"].each do |row|
                
                @feature.scenarios.last.example.example_rows.build
                
                row["cells"].each do |cell|
                  
                    @feature.scenarios.last.example.example_rows.last.example_cells.build :name => cell
                  
                end
              end
            end
                  
            scenario["steps"].each do |step|
              
              status = "passed"
              errormsg = ""
              
              if scenario["type"] != "scenario_outline"
                status =  step["result"]["status"]
              
                if feature_completed == true
                  if step["result"]["status"] == "skipped" || step["result"]["status"] == "failed"
                    feature_completed = false
                  end
                end
                
                if scenario_completed == true
                  if step["result"]["status"] == "skipped" || step["result"]["status"] == "failed"
                    scenario_completed = false
                  end
                end
                
                errormsg = step["result"]["error_message"]
                
              end
              
              
             
                  
                @feature.scenarios.last.steps.build  :keyword => step["keyword"].chop,
                                              :name => step["name"],
                                              :line => step["line"],
                                              #:location => step["match"]["location"],
                                              :status => status,
                                              :error_msg => errormsg
                  
  
                if step["rows"] != nil
                  step["rows"].each do |row|
                    @feature.scenarios.last.steps.last.step_rows.build
                    
                     row["cells"].each do |cell|
                         @feature.scenarios.last.steps.last.step_rows.last.step_cells.build :name => cell    
                     end
                  end
                end                                                     
                                            
            end
            
            @feature.scenarios.last.completed = scenario_completed
          end
          
          @feature.done = feature_completed
          
          if @feature.save
            puts "Deu bem"
          else
            puts "Erro"
            puts @feature.errors.full_messages
          end 
        end   
        
        
        #parse dos steps implementados
        
        project.implemented_steps.destroy_all
        
        Dir.glob('features/step_definitions/**/*.rb').each do |filename|
          
          file = File.open(filename)
          
          file.each do |line|
            match = line.match /^\s*(And|When|Given|Then)\s*\/(.*)\//  
            if ( match )
              
              project.implemented_steps.create(
                  filename: filename.split('/').last,
                  name: match.to_a.last
              )
              
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
