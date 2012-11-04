class UserController < ApplicationController
  before_filter :login_required, :except => [:login]
  before_filter :is_admin, :only => [:new, :destroy]
  before_filter :is_admin_or_user, :only => [:edit, :update]

  def index
    @user = get_current_user
    if @user.nil?
       @projects = []
    else
       @projects = @user.projects
    end
    # @projects = Project.find(:all)
  end

  def show_users
    @users= User.all
  end

  def new
    if request.post?
      user_hash = params[:user]
      @new = User.create_user(user_hash)
      flash[:notice]= "User '#{@new.first}' '#{@new.last}' created."
      redirect_to "/user/show_users"
    end
  end

  def destroy
    @user = get_current_user
    @user.deactivate_user(params[:uid])
    flash[:notice] = "User deactivated."
    redirect_to "/user/show_users"
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_username(params[:user]["username"])
    @user.update_attributes!(params[:user]) #handle exceptions if the ! throws one.
    flash[:notice] = "User #{@user.first} #{@user.last} was successfully updated."
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
