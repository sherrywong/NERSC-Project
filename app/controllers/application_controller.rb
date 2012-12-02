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

  def is_admin
    if !get_current_user.admin?
  redirect_to :controller => "user", :action=> "index", :notice=>"Sorry, you have to be an admin to perform this action."
    end
  end

  def is_admin_or_user
    if get_current_user.admin? or get_current_user.username==User.find_by_id(params["id"].to_i).username
    else
      flash[:notice] = "Sorry, you have to be an admin to edit someone else's account information."
      redirect_to :controller => "user", :action => "index"
    end
  end


  def is_admin_or_powner
    if get_current_user.admin? or get_current_user.powner?(params[:pid])
      return true
    end
    redirect_to :controller => "user", :action => "index", :notice=> "Sorry, you have to be an admin or project owner to perform this action."
    return false
  end

  def is_admin_or_powner_or_rowner
    if get_current_user.admin? or get_current_user.powner?(params[:pid]) or get_current_user.rowner?(params[:rid])
      return true
    end
    redirect_to risk_index_path(params[:pid]), :notice=> "Sorry, you have to be an admin or project owner or risk owner to perform this action."
    return false
  end

  def get_current_user
    return User.find_by_id(session[:uid])
  end

  def user_for_paper_trail
    get_current_user
  end
end
