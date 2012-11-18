class RiskController < ApplicationController
  before_filter :login_required
  before_filter :project_id_matches_user
  before_filter :is_admin_or_member, :only => [:new, :edit]
  before_filter :is_admin, :only =>[:destroy]

  def index
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    sort = params[:sort] || session[:sort]
    case sort
      when "title"
      @risks = @project.risks.sort_by { |risk| risk.title }
      when "status"
      @risks = @project.risks.sort_by { |risk| risk.status }
      else
        @risks = @project.risks
    end
    # @risks = @project.risks
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
    @user = get_current_user
    @risk = Risk.find_by_id(params[:rid])
    if @risk.nil?
        flash[:notice] = "That risk does not exist."
        redirect_to "/user/index"
    end
    #include error handling...
  end

  def update
    @user = get_current_user
    @risk = Risk.find_by_id(params[:rid])
    if @user.update_risk(params[:risk], @risk).errors.empty?
      flash[:notice] = "Risk '#{@risk.title}' was successfully updated."
      redirect_to risk_index_path(params[:pid])
    else 
        #otherwise, stay on same page, show all error messages in view
        flash[:notice] = "Risk was not successfully updated"
        redirect_to edit_risk_path(params[:pid], params[:rid])
    end
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
