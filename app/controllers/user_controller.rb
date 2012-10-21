class UserController < ApplicationController
  #You can find "login_required" in application_controller.rb"
  before_filter :login_required, :except => [:login]

  def create
    user_hash = [:email => params[:email], :first => params[:first], :last => params[:last], :password => params[:first], :username => params[:usrname]]
    User.add_new_user(user_hash)
  end

  def login
    if request.post? #If the form was submitted
      user = Users.find(:first, :conditions=>['username=?',(params[:username])]) #Find the user based on the name submitted
      if !user.nil? && user.password==params[:password] #Check that this user exists and it's password matches the inputted password
        session[:uid] = user.id #If so log in the user
        redirect_to :action => "show_profile" #And redirect to their profile
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

end
