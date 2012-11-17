class ApplicationController < ActionController::Base
  protect_from_forgery

  def login_required
     if session[:uid]==nil
       redirect_to :controller => "user", :action=> "login", :notice=>"Please log in to view this page"
     end
  end

  def sortable(column, title=nil)
    title || column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}

  end

  def project_id_matches_user
    if !get_current_user.admin? and ProjectMembership.where(:user_id => session[:uid]).where(:project_id=>params[:pid]).first == nil
      redirect_to :controller => "user", :action=> "index", :notice=>"Sorry, you don't have access to the requested project."
    end
  end

=begin
  def risk_id_matches_user
     if get_current_user.admin? or Risk.find_by_id(params[:rid]).owner_id == session[:uid]
       return true
     else
       redirect_to :controller => "user", :action=> "index", :notice=>"Sorry, you have to be a member of this project to perform this action."
       return false
     end
  end
=end

  def is_admin
    if !get_current_user.admin?
  redirect_to :controller => "user", :action=> "index", :notice=>"Sorry, you have to be an admin to perform this action."
    end
  end

  def is_admin_or_user
    if !get_current_user.admin? and get_current_user!=User.find_by_id(params[:id])
      flash[:notice] = "Sorry, you have to be an admin to edit someone else's account information."
      redirect_to :controller => "user", :action => "show_users"
    end
  end


  def is_admin_or_owner
    if get_current_user.admin? or get_current_user.owner?(params[:pid])
      return true
    end
    redirect_to :controller => "user", :action => "index", :notice=> "Sorry, you have to be an admin or project owner to perform this action."
    return false
  end

  def is_admin_or_member
    if not get_current_user.admin? and not Project.find_by_id(params[:pid]).has_member?(get_current_user.id)
       redirect_to :controller => "user", :action => "index", :notice => "Sorry, you have to be an admin or project member to perform this action."
    end
  end

  def get_current_user
    return User.find_by_id(session[:uid])
  end
end
