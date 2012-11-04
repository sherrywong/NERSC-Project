class RiskController < ApplicationController
  before_filter :login_required
  before_filter :project_id_matches_user
  before_filter :risk_id_matches_user, :only => [:destroy] 
  before_filter :is_admin, :only =>[:new, :destroy]

  def new
    if request.post?
      @usr = get_current_user
      @rsk = @usr.create_risk_for_project(params[:pid],params[:risk])
      flash[:notice] = "Risk created."
      redirect_to risk_index_path(params[:pid])
      end
  end

  def destroy
    @risk = Risk.find(params[:rid])

    @risk.destroy if Risk.count > 1
    flash[:notice] = "Risk '#{@risk.name}' deleted."
    redriect_to risk_path
  end

  def edit
    @risk = Risk.find_by_id(params[:rid])
  end

  def update
    @risk = Risk.find_by_id(params[:rid])
    @risk.update_attributes!(params[:risk])
    flash[:notice] = "Risk was successfully updated."

    redirect_to risk_index_path(params[:pid])
  end

  def index
    puts "PARAMS", params[:pid]
    @project = Project.find_by_id(params[:pid])
    @risks = @project.risks
  end

end
