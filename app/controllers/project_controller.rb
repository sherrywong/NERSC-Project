class ProjectController < ApplicationController

  before_filter :login_required
  before_filter :project_id_matches_user, :except => [:new]
  before_filter :is_admin_or_powner, :only => [:destroy, :update, :add_members, :reactivate]
  before_filter :is_admin, :only =>[:new]

  add_breadcrumb "Home", :user_index_path

  def index
    @user = get_current_user
    if @user.admin?
      @projects = Project.all
    else
      @projects = @user.projects
    end
  end

  def show
    @users = User.all
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    if @project.nil?
      flash[:notice] = "That project does not exist."
      redirect_to "/user/index"
    end
    @proj_members = @project.members
    sort = params[:sort] || session[:sort]
    case sort
      when "members"
        @proj_members = @proj_members.sort_by {|usr| usr.username}
      when "first"
        @proj_members = @proj_members.sort_by {|usr| usr.first}
      when "last"
        @proj_members = @proj_members.sort_by {|usr| usr.last}
      when "email"
        @proj_members = @proj_members.sort_by {|usr| usr.email}
      end
  end

  def new
    @users = User.all
    @user = get_current_user
    @new = true
    if request.post?
      @project = @user.create_project(params[:project])
      if @project.errors.empty?
        flash[:notice] = "Project '#{@project.name}' created."
   redirect_to "/project/#{@project.id}"
      else #Stays on same page.
        flash[:notice] = @project.errors[:owner].to_s
      end
    end
  end


  def edit
    @users = User.all
    @new = false
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    @errors = params[:errors]
    if @project.nil?
      flash[:notice] = "That project does not exist."
      redirect_to "/user/index"
    end
    #@project.errors=params[:errors]
    @proj_members = @project.members
    sort = params[:sort] || session[:sort]
    case sort
      when "members"
        @proj_members = @proj_members.sort_by {|usr| usr.username}
      when "first"
        @proj_members = @proj_members.sort_by {|usr| usr.first}
      when "last"
        @proj_members = @proj_members.sort_by {|usr| usr.last}
      when "email"
        @proj_members = @proj_members.sort_by {|usr| usr.email}
    end
    add_breadcrumb @project.name, show_project_path(params[:pid])
    if request.post?
      @project = @user.update_project(Project.find_by_id(params[:pid]), params[:project])
      if @project.errors.empty?
        flash[:notice] = "Project '#{@project.name}' was succesfully updated."
        redirect_to "/project/#{@project.id}"
      end
    end

  end

=begin
  def update
    @user = get_current_user
<<<<<<< HEAD
    @project = Project.find_by_id(params[:pid])
    @user.update_project(@project, params[:project])
    flash[:notice] = "Project '#{@project.name}' was succesfully updated."
    redirect_to "/project/#{@project.id}"

=======
    @proj = @user.update_project(Project.find_by_id(params[:pid]), params[:project])
    if @proj.errors.empty?
      flash[:notice] = "Project '#{@proj.name}' was succesfully updated."
      redirect_to "/project/#{@proj.id}"
    else
      redirect_to edit_project_path(params[:pid], :errors => @proj.errors, :hash=>params[:project])
    end
>>>>>>> 40734fa46e30a461de672c1fbeb1b257ccc9ad2b
  end
=end

  def destroy
    @project = Project.find(params[:pid])
    if @project != nil
      get_current_user.deactivate_project(params[:pid])
    end
    redirect_to user_index_path, :notice => "Project '#{@project.name}' deactivated."
  end

  def reactivate
    @project = Project.find(params[:pid])
    if @project != nil
      get_current_user.reactivate_project(params[:pid])
    end
    redirect_to user_index_path, :notice => "Project '#{@project.name}' reactivated."
  end


  def add_members
    members = params[:members]
    @project = Project.find_by_id(params[:pid])
    members_list = members[0].split(", ")
    @members = members_list
    member_id_list = Array(members_list.length)
	all_ok = true
	invalid_list = [];
    members_list.each do |member_name|
      member = User.find_by_username(member_name)
      if member and member.active?
        member_id = member.id
        member_id_list << member_id
      else
		all_ok = false
		invalid_list << member_name
	  end
    end
	if all_ok
		flash[:notice] = "All members added successfully."
	else
		flash[:notice] = "The following member(s) are either nonexistent or inactive: #{invalid_list}"
	end
    @project.add_members(member_id_list)
    redirect_to edit_project_path(params[:pid])
  end


  def remove_member
    @project = Project.find_by_id(params[:pid])
    @member= User.find_by_id(params[:uid])
    if @project.owner != @member
      @project.remove_member(params[:uid])
      flash[:notice] = "Removed #{@member.first} #{@member.last} from this project."
      redirect_to edit_project_path(params[:pid])
    else
      flash[:errors] = "Cannot remove project owner from the project. Please reassign project owner first."
      redirect_to edit_project_path(params[:pid])
    end
  end

end
