class RiskController < ApplicationController
  before_filter :login_required
  #before_filter :risk_id_matches_user


  def new
    if request.post?
      User.create_risk_for_project(params[:project],params[:risk])
      flash[:notice] = "Risk created."
      redirect_to "/user/risk/index"
      end
  end

  def destroy
    @risk = Risk.find(params[:id])

    @risk.destroy if Risk.count > 1
    flash[:notice] = "Risk '#{@risk.name}' deleted."
    redriect_to risk_path
  end

  def edit
    @risk = Risk.find_by_id(params[:id])

    #update
    @risk.update_attributes!(params[:risk])
    flash[:notice] = "Risk '#{risk.name}' was successfully updated."

    redirect_to_user_risk(@risk)
  end

  def index
    @risks = Risk.find(:all)
  end

end
