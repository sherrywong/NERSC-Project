class ProjectController < ApplicationController
  before_filter :login_required
  before_filter :project_id_matches_user, :except => [:new]
  before_filter :is_admin_or_owner, :only => [:destroy, :edit, :update, :add_members]
  before_filter :is_admin, :only =>[:new]


  def new
    if request.post?
      @usr = get_current_user
      @proj = @usr.create_project(params[:project])
      if @proj
      #check for errors here for error messages
        redirect_to "/user/project/index", :notice => "Project created."
      else
        redirect_to "/user/project/index", :notice => "Error occured when creating project."
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.count > 1
      User.deactivate_project(params[:id])
      @project.destroy
    end
    redriect_to project_path, :notice => "Project '#{@proj.name}' deactivated."
  end

  def edit
    @project = Project.find_by_id(params[:pid])
    if @project.nil?
        redirect_to "/user/project/index", :notice => "That project does not exist."
    end
    #flash[:notice] = "Project was edited." #doesn't edit just render the edit page?
    #include error handling...
  end

  def update
    @project = Project.find_by_name(params[:project]["name"])
    @project.update_attributes!(params[:project])
    redirect_to "/user/project/index", :notice => "Project was succesfully updated."
  end

  def add_members
    members = params[:members]
    puts "MEMBERS", members
    @project = Project.find_by_id(params[:pid])
    members_list = members[0].split(", ")
    @members = members_list
    member_id_list = Array(members_list.length)
    members_list.each do |member|
      member = User.find_by_username(member)
      member_id = member.id
      member_id_list << member_id
    end
    puts "MEM LIST", members_list
    flash[:notice] = "Members updated."
    @project.add_members(member_id_list)
    redirect_to edit_project_path(params[:pid])
  end

  def index
    @user = get_current_user
    @projects = @user.projects
    #Project.all if we want to show all users
  end

end
