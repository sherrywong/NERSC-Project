class UserController < ApplicationController
  #You can find "login_required" in application_controller.rb"
  before_filter :login_required, :except => [:login]
  before_filter :is_admin, :only => [:create, :edit, :destroy, :show_users]

  def index
     user = User.find_by_id(session[:uid])
     if user.nil?
        @projects = []
     else
        @projects = user.projects
     end
    # @projects = Project.find(:all)
  end

  def show_users
    @users= User.all
  end

  def new
    if request.post?

    user_hash = params[:user]
    User.add_new_user(user_hash)
    redirect_to "/user/show_users", :notice => "User created."
      end
  end

  def destroy
    @user = User.find(params[:id])
    if User.count > 1
      User.deactivate_user(params[:id])
      @user.destroy
    end
    flash[:notice] = "User '#{@user.first}' '#{@user.last}' deleted."
    redirect_to user_path
  end

  def edit
    @user = User.find_by_id(params[:id])

    #updating user
    @user.update_attributes!(params[:user])
    flash[:notice] = "User '#{user.first}' '#{user.last}' was successfully updated."
    redirect_to user_path(@user)
  end

  def login
    if request.post? #If the form was submitted
      if @user= User.authenticate(params[:username], params[:password]) #Check that this user exists and it's password matches the inputted password
        session[:uid] = @user.id #If so log in the user
        redirect_to :action => "index" #And redirect to their profile
      elsif User.find(:first, :conditions=>['username=?',(params[:username])])==nil
        redirect_to :action => "login", :notice=> "We don't have a user by this username. Please contact an administrator to be granted access to the application."
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
