class ProjectController < ApplicationController
  before_filter :login_required
  #before_filter :project_id_matches_user
  #before_filter :is_admin_or_owner, :only => [:destroy, :edit, :update]


  def new
    if request.post?
      @usr = get_current_user
      @proj = @usr.create_project(params[:project])
      if @proj
      #check for errors here for error messages
        flash[:notice] = "Project created."
      else
        flash[:notice] = "Error occured when creating project"
      end
      redirect_to "/user/project/index"
  end

  def destroy
    @project = Project.find(params[:pid])
    if @project.count > 1
      User.deactivate_project(params[:pid])
      @project.destroy
    end
    flash[:notice] = "Project '#{@proj.name}' deleted."
    redriect_to project_path
  end

  def edit
    @project = Project.find_by_id(params[:pid])
    flash[:notice] = "Project was edited."
  end

  def update
    @project = Project.find_by_name(params[:project]["name"])
    @project.update_attributes!(params[:project])
    flash[:notice] = "Project was successfully updated."

    redirect_to "/user/project/index"
  end

  def index
    @projects = Project.find_by_users(:uid)
  end

end

