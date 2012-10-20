class UserController < ApplicationController
  #You can find "login_required" in application_controller.rb"
  #before_filter :login_required, :except => [:login]
  #before_filter :is_admin, :only => [:create, :edit, :destroy, :show_users]

  def index
    @projects = ProjectMembership.find_by_user_id(session[:uid]).projects
  end

  def show_users
    @users= User.all
  end

  def new
    if request.post?
    user_hash = [:email => params[:email], :first => params[:first], :last => params[:last], :password => params[:first], :username => params[:usrname]]
    User.add_new_user(user_hash)
    flash[:notice] = "User '#{@user.first}' '#{@user.last}' created."
    redirect_to "/user/index"
      end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy if User.count > 1
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
      user = User.find(:first, :conditions=>['username=?',(params[:username])]) #Find the user based on the name submitted
      if !user.nil? && user.password==params[:password] #Check that this user exists and it's password matches the inputted password
        session[:uid] = user.id #If so log in the user
        redirect_to :action => "index" #And redirect to their profile
      elsif user.nil?
        redirect_to :action => "login", :notice=> "We don't have a user by this username. Please contact an administrator to be granted access to the application."
      else user.password!=params[:password]
        redirect_to :action => "login", :notice=> "Incorrect password. Please try again."
      end
    end
  end

  def logout
    session[:uid] = nil #Logs out the user
    redirect_to :action => "login" #redirect to log-in screen
  end

  def index
    @users = User.find(:all)
  end

end
