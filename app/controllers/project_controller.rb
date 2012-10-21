class ProjectController < ApplicationController.rb
  before_filter :login_required, :except => [:login]

  def create
    @project = Project.new(params[:project]).save
    flash[:notice] = "Project '#{@project.name}' created."
  end

  def destroy
    @project = Project.find(params[:id])

    @project.destroy if Project.count > 1
    flash[:notice] = "Project '#{@project.name}' deleted."
    redriect_to project_path
  end

  def edit
    @project = Project.find_by_id(params[:id])

    #update
    @project.update_attributes!(params[:user])
    flash[:notice] = "Project '#{project.name}' was successfully updated."

    redirect_to_user_project(@project)
  end

end

