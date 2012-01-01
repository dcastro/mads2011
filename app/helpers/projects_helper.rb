module ProjectsHelper
  
  def destroy_tag(project)
    link_to('Destroy', project, confirm: 'Are you sure?', method: :delete) + ' |' if User.find(session[:id]).role_in_project(project.id) == "Manager"
  end
end
  