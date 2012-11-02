class RiskController < ApplicationController
  before_filter :login_required
  #before_filter :risk_id_matches_user


  def new
    if request.post?
      @usr = get_current_user
      @rsk = @usr.create_risk_for_project(params[:pid],params[:risk])
      flash[:notice] = "Risk created."
      redirect_to "/user/risk/index"
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
    flash[:notice] = "Risk '#{risk.name}' was successfully updated."

    redirect_to_user_risk(@risk)
  end

  def index
    @risks = Risk.find_by_projects(:pid)
  end

end
