class UserController < ApplicationController
  before_filter :login_required, :except => [:login]
  before_filter :is_admin, :only => [:new, :edit, :destroy, :show_users]

  def index
    # user = User.find_by_id(session[:uid])
    @usr = get_current_user
    if @usr.nil?
       @projects = []
    else
       @projects = @usr.projects
    end
    # @projects = Project.find(:all)
  end

  def show_users
    @users= User.all
  end

  def new
    @usr = get_current_user
    if request.post?
      user_hash = params[:user]
    @usr.create_user(user_hash)
    redirect_to "/user/show_users", :notice => "User created."
      end
  end

  def destroy
    @user = get_current_user
    # @user.deactivate_user(params[:uid])
    @user.deactivate_user(params[:id])
    flash[:notice] = "User '#{@user.first}' '#{@user.last}' deleted."
    redirect_to "/user/show_users", :notice => "User deleted"
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_username(params[:user]["username"])
    #check for permission to update first
    @user.update_attributes!(params[:user]) #handle exceptions if the ! throws one.
    flash[:notice] = "User was successfully updated."
    redirect_to "/user/show_users"
  end

  def login
    if request.post? #If the form was submitted
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
