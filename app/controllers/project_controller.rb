
class ProjectController < ApplicationController
  #before_filter :login_required
  #before_filter :project_id_matches_user


  def create
    @project = Project.new(params[:project]).save
    flash[:notice] = "Project '#{@project.name}' created."
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

  def destroy
    @project = Project.find(params[:id])

    @project.destroy if Project.count > 1
    flash[:notice] = "Project '#{@project.name}' deleted."
    redriect_to project_path
  end

  def edit
    @project = Project.find_by_id(params[:id])

    #update
    @project.update_attributes!(params[:user])
    flash[:notice] = "Project '#{project.name}' was successfully updated."

    redirect_to_user_project(@project)
  end

  def index
    @projects = Project.find(:all)
  end

end

