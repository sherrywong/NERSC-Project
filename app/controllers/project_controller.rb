class ProjectController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_filter :login_required
  before_filter :project_id_matches_user, :except => [:new]
  before_filter :is_admin_or_owner, :only => [:destroy, :update, :add_members]
  before_filter :is_admin, :only =>[:new]

  add_breadcrumb "Home", :user_index_path

  def index
    @user = get_current_user
    if @user.admin?
      @projects = Project.all
    else
      @projects = @user.projects
    end
    #Project.all if we want to show all users
  end



  def new

    @user = get_current_user
    if request.post?
      @proj = @user.create_project(params[:project])
      if @proj.errors.empty?
        flash[:notice] = "Project '#{@proj.name}' created."
      else #Stays on same page.
        flash[:notice] = @proj.errors[:owner].to_s
      end
        redirect_to "/user/index"
    end
  end



  def edit
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    sort = params[:sort] || session[:sort]
    case sort
      when "members"
        @proj_members = @project.members
        @proj_members = @proj_members.sort_by {|usr| usr.username}
      when "first"
        @proj_members = @project.members
        @proj_members = @proj_members.sort_by {|usr| usr.first}
      when "last"
        @proj_members = @project.members
        @proj_members = @proj_members.sort_by {|usr| usr.last}
      when "email"
        @proj_members = @project.members
        @proj_members = @proj_members.sort_by {|usr| usr.email}
      else
        @proj_members = @project.members
    end


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

  def destroy
    @project = Project.find(params[:pid])
    if @project != nil
      get_current_user.deactivate_project(params[:pid])
    end
    redirect_to user_index_path, :notice => "Project '#{@project.name}' deactivated."
  end

  def add_members
    members = params[:members]
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

  def sort_column
    Project.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
