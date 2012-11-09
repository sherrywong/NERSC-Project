class RiskController < ApplicationController
  before_filter :login_required
  before_filter :project_id_matches_user
  before_filter :is_admin_or_member, :only => [:new, :edit]
  before_filter :is_admin, :only =>[:destroy]

  def new
    if request.post?
      @usr = get_current_user
      @rsk = @usr.create_risk_for_project(params[:pid],params[:risk])
      flash[:notice] = "Risk '#{@rsk.title}' created."
      redirect_to risk_index_path(params[:pid])
    end
  end

  def destroy
    @risk = Risk.find(params[:rid])
    if @risk != nil
      get_current_user.deactivate_risk(params[:rid])
      @risk.destroy
    end
    redirect_to risk_path, :notice => "Risk '#{@risk.name}' deactivated."
  end

  def destroy
    @project = Project.find(params[:pid])
    if @project != nil
      get_current_user.deactivate_project(params[:pid])
      @project.destroy
    end
    redirect_to user_index_path, :notice => "Project '#{@project.name}' deactivated."
  end


  def edit
    @risk = Risk.find_by_id(params[:rid])
  end

  def update
    @risk = Risk.find_by_id(params[:rid])
    @risk.update_attributes!(params[:risk])
    flash[:notice] = "Risk '#{@risk.title}' was successfully updated."
    redirect_to risk_index_path(params[:pid])
  end

  def index
    puts "PARAMS", params[:pid]
    @project = Project.find_by_id(params[:pid])
    @risks = @project.risks
  end

end
