class UserController < ApplicationController
  before_filter :login_required, :except => [:login]
  before_filter :is_admin, :only => [:new, :destroy, :show_users, :reactivate]
  before_filter :is_admin_or_user, :only => :edit

  autocomplete :username, :full => true

  def index
    @user = get_current_user
    sort = params[:sort] || session[:sort]
    if @user.admin?
      @projects = Project.all
    else
      @projects = @user.projects
    end
    case sort
      when "title"
        @projects.sort_by { |project| project.name }
      when "owner"
        @projects.sort_by { |project| project.owner_username }
      when "status"
        @projects.sort_by { |project| project.status}
     end
  end

  def show_users
	add_breadcrumb "Users", show_users_path
    sort = params[:sort] || session[:sort]
    case sort
      when "username"
        @users = User.order("username")
      when "first"
        @users = User.order("first")
      when "last"
        @users = User.order("last")
      when "email"
        @users = User.order("email")
      when "admin"
  @users = User.order("admin")
      when "status"
        @users = User.order("status")
      else
        @users = User.all
    end
  end

  def new
	add_breadcrumb "Users", show_users_path
    add_breadcrumb "Create New User", user_new_path
    if request.post?
      user_hash = params[:user]
      @new = get_current_user.create_user(user_hash)
      if @new.errors.empty?
        UserMailer.welcome_email(@new).deliver
        flash[:notice]= "User '#{@new.first} #{@new.last}'created."
		#send mail
		redirect_to show_users_path
      else
        flash[:notice] = @new.errors.full_messages.join(", ")
		redirect_to user_new_path
      end
      
    end
  end

  def edit
    @edit = true
    @current_user = get_current_user
    @curr_user = (params[:id].to_s == session[:uid].to_s)
    @user = User.find_by_id(params[:id])

    add_breadcrumb "Users", show_users_path if @user.admin
	add_breadcrumb "#{@user.username}", edit_user_path(@user.id)

    @user_username = @user.username
    @user_admin = @user.admin
    if request.post?
      @user = User.find_by_username(params[:user]["username"])
      if @user.update_attributes(params[:user])
        flash[:notice] = "User #{@user.first} #{@user.last} was successfully updated."
	 if get_current_user.admin?
	   redirect_to show_users_path
	 else
          redirect_to user_index_path
	 end
      end
    end
  end

=begin
  def update
    @user = User.find_by_username(params[:user]["username"])
    if @user.update_attributes(params[:user])
		flash[:notice] = "User #{@user.first} #{@user.last} was successfully updated."
		if get_current_user.admin?
			redirect_to show_users_path
		else
			redirect_to user_index_path
		end
	else
		flash[:notice] = @user.errors.full_messages.join(", ")
		redirect_to edit_user_path(@user.id)
	end
	
  end
=end

  def destroy
    @user = get_current_user
    if @user.deactivate_user(params[:uid])
      flash[:notice] = "User deactivated."
    else
      flash[:notice] = "You cannot deactivate this user."
    end
    redirect_to show_users_path
  end

  def reactivate
    @user = get_current_user
    if @user.reactivate_user(params[:uid])
      flash[:notice] = "User reactivated."
    else
      flash[:notice] = "You cannot reactivate this user."
    end
    redirect_to show_users_path
  end

  def login
    if request.post? #If form was submitted
      if @user= User.authenticate(params[:username], params[:password]) and @user and @user.active? #Check that user exists, password is correct, and status is active
        session[:uid] = @user.id #If so log in the user
        redirect_to :action => "index" #And redirect to their profile
      elsif not @user=User.find(:first, :conditions=>['username=?',(params[:username])])
        redirect_to :action => "login", :notice =>  "We don't have a user by this username. Please contact an administrator to be granted access to the application."
      elsif @user.status != "active"
        redirect_to :action => "login", :notice=> "Your account has been deactivated. Please contact an administrator if this was done in error."
      else
        redirect_to :action => "login", :notice=> "Incorrect password. Please try again."
      end
    end
  end

  def logout
    session[:uid] = nil #Logs out the user
    redirect_to :action => "login", :notice => "You have been logged out." #redirect to log-in screen
  end

end
