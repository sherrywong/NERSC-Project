class ProjectController < ApplicationController
  before_filter :login_required
  before_filter :project_id_matches_user, :except => [:new]
  before_filter :is_admin_or_owner, :only => [:destroy, :update, :add_members]
  before_filter :is_admin, :only =>[:new]


  def new
    @user = get_current_user
    if request.post?
      @proj = @user.create_project(params[:project])
      if @proj
        flash[:notice] = "Project '#{@proj.name}' created."
      else
        flash[:notice] = "Error occured when creating project."
      end
      redirect_to "/user/index"
    end
  end

  def destroy
    @project = Project.find(params[:pid])
    if @project != nil
      get_current_user.deactivate_project(params[:pid])
    end
    redirect_to user_index_path, :notice => "Project '#{@project.name}' deactivated."
  end

  def edit
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    if @project.nil?
        flash[:notice] = "That project does not exist."
        redirect_to "/user/index"
    end
    #include error handling...
  end

  def update
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    @user.update_project(@project, params[:project])
    #@project.update_attributes!(params[:project])
    flash[:notice] = "Project '#{@project.name}' was succesfully updated."
    redirect_to "/user/index"
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
      if not member.nil?
        member_id = member.id
        member_id_list << member_id
        flash[:notice] = "Members updated."
      else
        flash[:notice] = "Error: This person is not a current user."
      end
    end
    puts "MEM LIST", members_list
    @project.add_members(member_id_list)
    redirect_to edit_project_path(params[:pid])
  end

  def remove_member
    @project = Project.find_by_id(params[:pid])
    @member= User.find_by_id(params[:uid])
    @project.remove_member(params[:uid])
    flash[:notice] = "Removed #{@member.first} #{@member.last} from this project."
    redirect_to edit_project_path(params[:pid])
  end

  def index
    @user = get_current_user
    @projects = @user.projects
    #Project.all if we want to show all users
  end

end
