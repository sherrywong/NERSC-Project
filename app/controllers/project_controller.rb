class ProjectController < ApplicationController
  before_filter :login_required
  #before_filter :project_id_matches_user
  #before_filter :is_admin_or_owner, :only => [:destroy, :edit]


  def new
    if request.post?
      User.create_project(params[:project])
      flash[:notice] = "Project created."
      redirect_to "/user/project/index"
      end
  end

  def destroy
    @project = Project.find(params[:id])

    if Project.count > 1
      User.deactivate_project(params[:id])
      @project.destroy
    end
    flash[:notice] = "Project '#{@project.name}' deleted."
    redriect_to project_path
  end

  def edit
    @project = Project.find_by_id(params[:id])
  end

  def update
    @project = Project.find_by_name(params[:project]["name"])
    @project.update_attributes!(params[:project])
    flash[:notice] = "Project was successfully updated."

    redirect_to "/user/project/index"
  end

  def index
    @projects = Project.find(:all)
  end

end

