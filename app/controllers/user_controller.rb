class UserController < ApplicationController
  before_filter :login_required, :except => [:login]
  before_filter :is_admin, :only => [:new, :destroy, :show_users]
  before_filter :is_admin_or_user, :only => :edit

  autocomplete :username, :full => true
  add_breadcrumb "Home", :user_index_path

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
      when "admin"
        @projects.sort_by { |project| project.admin}
      when "status"
        @projects.sort_by { |project| project.status}
     end
  end

  def show_users

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
      when "status"
        @users = User.order("status")
      else
        @users = User.all
    end
    # @users= User.all
  end

  def new
    add_breadcrumb "Users", show_users_path
    if request.post?
      user_hash = params[:user]
      @new = get_current_user.create_user(user_hash)
      if @new.errors.empty?
        flash[:notice]= "User '#{@new.first} #{@new.last}'created."
      else
        flash[:notice] = @new.errors[:owner].to_s
      end
      redirect_to "/user/show_users"
    end
  end

  def edit
    @edit = true
    if (params[:id].to_s == session[:uid].to_s)
      @curr_user = true
    else
      @curr_user = false
    end
    @user = User.find_by_id(params[:id])
    if (@user.admin)
      add_breadcrumb "Users", show_users_path
    end
    @user_username = @user.username
    @user_admin = @user.admin
  end

  def update
    @user = User.find_by_username(params[:user]["username"])
    @user.update_attributes!(params[:user]) #handle exceptions if the ! throws one.
    flash[:notice] = "User #{@user.first} #{@user.last} was successfully updated."
    redirect_to "/user/index"
  end

  def destroy
    @user = get_current_user
    if @user.deactivate_user(params[:uid])
      flash[:notice] = "User deactivated."
    else
      flash[:notice] = "You cannot deactivate this user."
    end
    redirect_to "/user/show_users"
  end

  def reactivate
    @user = get_current_user
    if @user.reactivate_user(params[:uid])
      flash[:notice] = "User reactivated."
    else
      flash[:notice] = "You cannot reactivate this user."
    end
    redirect_to "/user/show_users"
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
