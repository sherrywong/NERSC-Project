class ApplicationController < ActionController::Base
  protect_from_forgery

  def login_required
     if session[:uid]==nil
       redirect_to :controller => "user", :action=> "login", :notice=>"Please log in to view this page"
     end
  end

  def project_id_matches_user
    if !get_current_user.admin? and ProjectMembership.where(:user_id => session[:uid]).where(:project_id=>params[:pid]).first == nil
      redirect_to :controller => "user", :action=> "index", :notice=>"Sorry, you don't have access to the requested project."
    end
  end

  def risk_id_matches_user
     if get_current_user.admin? or Risk.find_by_id(params[:rid]).owner_id == session[:uid]
       return true
     else
       redirect_to :controller => "user", :action=> "index", :notice=>"Sorry, you have to be a member of this project to perform this action."
       return false
     end
  end

  def is_admin
    return get_current_user.admin?

#      return true
#    else 
#      redirect_to :controller => "user", :action=> "index", :notice=>"Sorry, you have to be an administrator to perform this action."
#      return false
#    end
  end

  def is_admin_or_owner
    if get_current_user.admin? or get_current_user.owner?(params[:pid]) 
      return true
    end
    redirect_to :controller => "user", :action => "index", :notice=> "Sorry, you have to be an administrator or project owner to perform this action."
    return false
  end 
  
  def get_current_user
    return User.find_by_id(session[:uid])
  end
end