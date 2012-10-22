class ApplicationController < ActionController::Base
  protect_from_forgery

  def login_required
    if session[:uid] #if there is a logged in user
      return true
    end #Otherwise redirect to login page
    redirect_to :controller => "user", :action=> "login", :notice=>"Please log in to view this page"
    return false 
  end
=begin
  def project_id_matches_user
    membership = ProjectMembership.where(:user_id => session[:user_id]).where(:project_id=>params[:proj_id]).first
    if membership != nil
      return true
    end
    redirect_to :controller => "user", :action=> "index", :notice=>"Sorry, you don't have access to the requested project."
    return false
    end
=end
  def is_admin
    if User.find_by_id(session[:uid]).admin?
      return true
    end
    redirect_to :controller => "user", :action=> "index", :notice=>"Sorry, you don't have permissions to modify users."
    return false
  end
end
