class RiskController < ApplicationController
  before_filter :login_required
  before_filter :project_id_matches_user
  before_filter :is_admin_or_member, :only => [:new, :edit]
  before_filter :is_admin, :only =>[:destroy]

  def index
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    @risks = @project.risks
  end

  def new
    @user = get_current_user
    if request.post?
      @rsk = Risk.create_risk(session[:uid], params[:pid], params[:risk])
      if @rsk.errors.empty?
        flash[:notice] = "Risk '#{@rsk.title}' created."
        redirect_to risk_index_path(params[:pid])
      else #Otherwise, stay on the same page, show all error messages in view
        flash[:notice] = "Error occurred when creating risk."
        redirect_to risk_index_path(params[:pid])
      end
    end
  end

  def edit
    @risk = Risk.find_by_id(params[:rid])
  end

  def update
    @user = get_current_user
    @risk = Risk.find_by_id(params[:rid])
    if @user.update_risk(params[:risk], @risk).errors.empty?
      flash[:notice] = "Risk '#{@risk.title}' was successfully updated."
      redirect_to risk_index_path(params[:pid])
    end #otherwise, stay on same page, show all error messages in view
    puts @risk.versions
  end

  def destroy
    @risk = Risk.find(params[:rid])
    if @risk != nil
      get_current_user.deactivate_risk(params[:rid])
    end
    redirect_to risk_index_path(params[:pid]), :notice => "Risk '#{@risk.title}' deactivated."
  end

end
