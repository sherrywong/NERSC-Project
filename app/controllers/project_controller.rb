class ProjectController < ApplicationController
  before_filter :login_required
  before_filter :project_id_matches_user, :except => [:new]
  before_filter :is_admin_or_owner, :only => [:destroy, :update, :add_members]
  before_filter :is_admin, :only =>[:new]


  def new
    if request.post?
      @usr = get_current_user
      @proj = @usr.create_project(params[:project])
      if @proj
        flash[:notice] = "Project '#{@proj.name}' created."
      else
        flash[:notice] = "Error occured when creating project."
      end
      redirect_to user_project_index_path
    end
  end

  def destroy
    @project = Project.find(params[:pid])
    if @project != nil
      get_current_user.deactivate_project(params[:pid])
      @project.destroy
    end
    redirect_to user_project_index_path, :notice => "Project '#{@project.name}' deactivated."
  end

  def edit
    @project = Project.find_by_id(params[:pid])
    if @project.nil?
        flash[:notice] = "That project does not exist."
        redirect_to "/user/project/index"
    end
    #include error handling...
  end

  def update
    @project = Project.find_by_name(params[:project]["name"])
    @project.update_attributes!(params[:project])
    flash[:notice] = "Project '#{@project.name}' was succesfully updated."
    redirect_to "/user/project/index"
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

  def remove_member
    @project = Project.find_by_id(params[:pid])
    @member= User.find_by_id(params[:uid])
    @projet.remove_member(params[:uid])
    flash[:notice] = "Removed #{@member.first} #{@member.last} from this project."
    redirect_to edit_project_path(params[:pid])
  end

  def index
    @user = get_current_user
    @projects = @user.projects
    #Project.all if we want to show all users
  end

end
